Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbUKWVOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUKWVOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUKWTJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:09:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:64484 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261420AbUKWTBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:01:46 -0500
Date: Tue, 23 Nov 2004 11:01:28 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration) query support
Message-ID: <20041123190128.GA31391@kroah.com>
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com> <20041122713.g6bh6aqdXIN4RJYR@topspin.com> <20041122222507.GB15634@kroah.com> <527jodbgqo.fsf@topspin.com> <20041123064120.GB22493@kroah.com> <52hdnh83jy.fsf@topspin.com> <20041123072944.GA22786@kroah.com> <20041123175246.GD4217@sventech.com> <20041123183813.GA31068@kroah.com> <52pt244cop.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52pt244cop.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 10:56:06AM -0800, Roland Dreier wrote:
>     Greg> No.  RCU is covered by a patent that only allows for it to
>     Greg> be implemented in GPL licensed code.  If you want to use RCU
>     Greg> in non-GPL code, you need to sign a license agreement with
>     Greg> the holder of the RCU patent.
> 
> Surely IBM can implement RCU in non-GPLed AIX code or license the
> patent to whoever they like, with whatever terms they like?

As holders of the patent, they can.  If you wish to do this, please
contact IBM's IP Licensing group :)

thanks,

greg k-h
