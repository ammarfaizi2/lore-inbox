Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbSLSV5Q>; Thu, 19 Dec 2002 16:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSLSV5Q>; Thu, 19 Dec 2002 16:57:16 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:17674 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S267189AbSLSV5P>;
	Thu, 19 Dec 2002 16:57:15 -0500
Date: Thu, 19 Dec 2002 23:04:11 +0100
From: romieu@fr.zoreil.com
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Are working modules going to be in 2.6?
Message-ID: <20021219230411.A2032@electric-eye.fr.zoreil.com>
References: <Pine.LNX.3.96.1021219154713.29567A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1021219154713.29567A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Thu, Dec 19, 2002 at 03:58:11PM -0500
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> :
[...]
> I have downloaded any number of modutil this and init-mod that, built them
> static, rolled my own initrd files, and as far as I can tell it just
> doesn't work with 2.5.48+.

Here it worked with 2.5.50 + module-init-tools-0.9. No special magic.
In-kernel 3c59x + initrd + (really gory style) nfs root.

If you're interested, kernel .config is available at:
http://electric-eye.fr.zoreil.com/2.5.50/misc/config.gz

--
Ueimor
