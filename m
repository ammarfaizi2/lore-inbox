Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUFWP2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUFWP2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUFWP2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:28:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:57533 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261988AbUFWP2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:28:49 -0400
Date: Tue, 22 Jun 2004 17:04:34 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix MSI-X setup
Message-ID: <20040623000434.GH13197@kroah.com>
References: <52lligqqlc.fsf@topspin.com> <521xk8qlx1.fsf@topspin.com> <52smcop5v7.fsf_-_@topspin.com> <20040622232301.GB13197@kroah.com> <52isdjkuwu.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52isdjkuwu.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 04:57:53PM -0700, Roland Dreier wrote:
>     Greg> Applied, thanks.
> 
> Great... I would suggest looking at applying the big patch that Long
> posted today, too, as it has lots of improvements.

Yes, I saw it, but it's just out for review, not ready to apply just
yet.  :)

thanks,

greg k-h
