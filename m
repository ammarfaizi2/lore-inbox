Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUEFHYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUEFHYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUEFHYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:24:20 -0400
Received: from pop-3.dnv.wideopenwest.com ([64.233.207.8]:43957 "EHLO
	pop-3.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S261802AbUEFHYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:24:19 -0400
Date: Thu, 6 May 2004 03:04:00 -0400
From: Eric Blade <eblade@blackmagik.dynup.net>
To: linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: Linux-kernel-daily-digest digest, Vol 3 #122 - 255 msgs
Message-Id: <20040506030400.21b470c8@debian>
In-Reply-To: <20040505110000.19914.85659.Mailman@lists.us.dell.com>
References: <20040505110000.19914.85659.Mailman@lists.us.dell.com>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message: 81
> Date: Tue, 04 May 2004 19:53:07 +0100
> From: Paulo Marques <pmarques@grupopie.com>
> Organization: GrupoPIE
> To: Bill Catlan <wcatlan@yahoo.com>
> Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
> Subject: Re: Possible to delay boot process to boot from USB subsystem?
> 
> This is a completely different error from "VFS: Cannot open root device" or 
> "unable to mount root".
> 
> Are you sure you have a "/sbin" directory with an *executable* "init" file on 
> the usb harddrive?
> 
> Does your init file depend on libraries that you do not have under "/lib"? (you 
> can check with "ldd init")
> 
> If your init is a script, does it specify a complete path to the interpreter, 
> and do you have an *executable* interpreter there? Does the interpreter require 
> libraries or is it static?
> 


*inserts a little notation here that this is one of the reasons why linux can some times be the biggest pain in the arse in the world.. error messages that tell you there's something wrong with Thing A, but it's really something wrong with Thing C or Thing D...*

