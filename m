Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSGIOxg>; Tue, 9 Jul 2002 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSGIOxf>; Tue, 9 Jul 2002 10:53:35 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:3084 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315442AbSGIOxe>; Tue, 9 Jul 2002 10:53:34 -0400
Date: Tue, 9 Jul 2002 16:56:09 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac1
Message-ID: <20020709145609.GA16669@louise.pinerecords.com>
References: <200207091433.g69EXGl04767@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207091433.g69EXGl04767@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 35 days, 6:43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like you found the version number boring this time, Alan,
and skipped right to -ac2. :)

kala@nibbler:~/src/linux-2.4.19-rc1-ac1$ grep ^EXTRAVERSION Makefile 
EXTRAVERSION = -rc1-ac2


T.



> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> 
> This is to get stuff moving again primarily. There is a lot of other
> pending stuff in the queue including promise and osb4 ide, fixing the
> pci fixup for the IDE bios mapping bugs etc.
> 
> Linux 2.4.19rc1-ac1
> 
> [snip]
