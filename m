Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284601AbSACJJN>; Thu, 3 Jan 2002 04:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284752AbSACJJE>; Thu, 3 Jan 2002 04:09:04 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:34551 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284601AbSACJIs>; Thu, 3 Jan 2002 04:08:48 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020102211038.C21788@thyrsus.com> 
In-Reply-To: <20020102211038.C21788@thyrsus.com>  <20020102174824.A21408@thyrsus.com> <Pine.LNX.4.33.0201030006120.427-100000@Appserv.suse.de> 
To: esr@thyrsus.com
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 09:08:14 +0000
Message-ID: <3021.1010048894@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
> Think useability.  On Macintoshes, you configure a kernel by moving
> the  equivalents of modules in and out of a system folder.  Users tune
> their kernels by moving files around -- no muttering of elaborate
> incantations required.  *That's* the direction we should be moving in;
> there is no  good technical reason for the process to be anywhere near
> as arcane as it is now. 

We have it better than that already. The distro vendor provides all the 
modules and they're automatically loaded on demand - you don't even need to 
move them into the system folder.

--
dwmw2


