Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263514AbUJ2VcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263514AbUJ2VcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUJ2VaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:30:07 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:14523 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263615AbUJ2VY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:24:28 -0400
Message-Id: <200410292124.i9TLOBIe014728@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.7.1.1 10/09/2004 with nmh-1.1
In-reply-to: <20041029221307.GB11016@mars.ravnborg.org> 
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.10-rc1-mm2 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Oct 2004 16:24:11 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Oct 2004 00:13:07 +0200, Sam Ravnborg wrote:
>On Fri, Oct 29, 2004 at 02:55:41PM -0500, Doug Maxey wrote:
>> 
>> Andrew, 
>> 
>> having some troubles on ppc64.  It looks like the changes in
>> the scripts/Makefile.{clean,build} are expecting include/asm to
>> exist in the source tree.  I don't see any related file except the
>> include/asm-$ARCH/Kbuild
>
>Fix attached.

Worked, thanks!


