Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262599AbTDAP1a>; Tue, 1 Apr 2003 10:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbTDAP1a>; Tue, 1 Apr 2003 10:27:30 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:45069 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262599AbTDAP13>; Tue, 1 Apr 2003 10:27:29 -0500
Date: Tue, 1 Apr 2003 16:38:52 +0100
From: John Levon <levon@movementarian.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@transmeta.com,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Convert APIC to driver model: now it works with SMP
Message-ID: <20030401153852.GA24356@compsoc.man.ac.uk>
References: <20030330193026.GA29499@elf.ucw.cz> <14730000.1049180682@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14730000.1049180682@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *190Nqe-0004qc-00*lNoLsG3xmN2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 11:04:42PM -0800, Martin J. Bligh wrote:

> arch/i386/oprofile/nmi_int.c:102: warning: initialization from incompatible pointer type
> arch/i386/oprofile/nmi_int.c: In function `init_nmi_driverfs':
> arch/i386/oprofile/nmi_int.c:129: warning: control reaches end of non-void function

Can you try Mikael's (preferable) patch ?

regards,
john
