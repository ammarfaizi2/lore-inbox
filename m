Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbUKXT7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbUKXT7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 14:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbUKXT7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 14:59:15 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:8149 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262826AbUKXT54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 14:57:56 -0500
Date: Wed, 24 Nov 2004 11:29:28 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration) query support
Message-ID: <20041124192928.GA2053@kroah.com>
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com> <20041122713.g6bh6aqdXIN4RJYR@topspin.com> <20041122222507.GB15634@kroah.com> <527jodbgqo.fsf@topspin.com> <20041123064120.GB22493@kroah.com> <52hdnh83jy.fsf@topspin.com> <20041123072944.GA22786@kroah.com> <20041123175246.GD4217@sventech.com> <20041123183813.GA31068@kroah.com> <52u0rfyrt2.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52u0rfyrt2.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 11:23:37AM -0800, Roland Dreier wrote:
>     Greg> No.  RCU is covered by a patent that only allows for it to
>     Greg> be implemented in GPL licensed code.  If you want to use RCU
>     Greg> in non-GPL code, you need to sign a license agreement with
>     Greg> the holder of the RCU patent.
> 
> Not to stir up the flames any further (and this is really a moot point
> since I got rid of our use of RCU)...
> 
> But given that I could implement the same API as in rcupdate.h as
> below without using IBM's patented technique, how does merely using
> this API cause code to require a patent license?

Consult your IP lawyer for issues like this, I am not one, and do not
have an answer for this.

thanks,

greg k-h
