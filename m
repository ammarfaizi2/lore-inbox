Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265703AbSJXWmb>; Thu, 24 Oct 2002 18:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265697AbSJXWmb>; Thu, 24 Oct 2002 18:42:31 -0400
Received: from tantale.fifi.org ([216.27.190.146]:45466 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S265696AbSJXWma>;
	Thu, 24 Oct 2002 18:42:30 -0400
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, tmolina@cox.net,
       haveblue@us.ibm.com
Subject: Re: more aic7xxx boot failure
References: <8800000.1035498319@w-hlinder>
From: Philippe Troin <phil@fifi.org>
Date: 24 Oct 2002 15:46:56 -0700
In-Reply-To: <8800000.1035498319@w-hlinder>
Message-ID: <87lm4nxxnj.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder <hannal@us.ibm.com> writes:

> >                                2.5 Kernel Problem Reports as of 22 Oct
> >    Status                 Discussion  Problem Title
> > 
> >    open                   04 Oct 2002 AIC7XXX boot failure
> >    1. http://marc.theaimsgroup.com/?l=linux-kernel&m=103356254615324&w=2
> > 
> 
> 
> This may be a different problem but it is related to the aic7xxx
> driver. My system is a 2-way PIII 500MHz 2.5GB RAM box. It boots
> if I remove the aic7xxx driver. This is on 2.5.44 btw. Works fine
> on 2.4.x.

What error do you get on boot?

Have you tried booting with "noapic"?

Phil.
