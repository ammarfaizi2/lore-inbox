Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277140AbRJLBMC>; Thu, 11 Oct 2001 21:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277138AbRJLBLw>; Thu, 11 Oct 2001 21:11:52 -0400
Received: from mail.webmaster.com ([216.152.64.131]:40664 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S277137AbRJLBLs> convert rfc822-to-8bit; Thu, 11 Oct 2001 21:11:48 -0400
From: David Schwartz <davids@webmaster.com>
To: <jalvo@mbay.net>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (988) - Registered Version
Date: Thu, 11 Oct 2001 18:12:13 -0700
In-Reply-To: <aebcstsuksjmoqvf1rseel7c3sqgobu4tc@4ax.com>
Subject: Re: Tainted Modules Help Notices
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20011012011217.AAA27996@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>URLs go bad and non-responsive regularly,,,
>john

	Yes, but modules that have available source code don't often morph into 
modules that don't. The desired information is whether or not the source code 
is easily available for debugging.

	Perhaps the best solution is to develop a 'kernel module license' that 
simply requires that the source code be made available to anyone who wishes 
to debug for the purpose of debugging. Complying with the terms of the 
'kernel module license' would give you module that don't taint the kernel. 

	The license would be liberal in that it would allow you to impose a wide 
array of other licensing terms that didn't interfere with debugging. Though 
NDA requirements or any form of explicit contract to obtain the source 
wouldn't be allowed.

	This license wouldn't be compatible with the GPL since it would be 
considered an additional restriction - the GPL doesn't require you to make 
source code available to anyone who wants it and this license would require 
you to do so. It would, however, be compatible with the BSD license. BSD 
licenses shouldn't automatically cause no tainting of the kernel because the 
BSD license doesn't assure that the source code will be available.

	Because this really isn't a copyright enforcement scheme, it's not clear (at 
least to me) how using the tag falsely would be a DMCA violation. However, if 
the tag were copyrighted, displaying it falsely would be a violation of 
several laws (including simple fraud).

	DS


