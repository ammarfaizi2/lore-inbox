Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVLOTrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVLOTrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVLOTrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:47:25 -0500
Received: from free.hands.com ([83.142.228.128]:41448 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1750913AbVLOTrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:47:24 -0500
Date: Thu, 15 Dec 2005 19:47:01 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ordering of suspend/resume for devices.  any clues, anyone?
Message-ID: <20051215194701.GG14978@lkcl.net>
References: <20051215143124.GD14978@lkcl.net> <20051215183744.GB16574@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215183744.GB16574@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 10:37:44AM -0800, Greg KH wrote:

> > am seeking some advice regarding power management - specifically
> > the ordering of devices "resume" functions being called.

> > <snip>

> > possible solutions, as i see them:
> 
> <snip>
> 
> Known issue, I'd take this to the linux-pm mailing list instead, as the
> people there are working on stuff for this.
 
 thanks greg.

 l.
