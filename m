Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266335AbSKZPDT>; Tue, 26 Nov 2002 10:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSKZPDS>; Tue, 26 Nov 2002 10:03:18 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:55697 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266335AbSKZPDR>; Tue, 26 Nov 2002 10:03:17 -0500
Subject: Re: [PATCH]  v850 additions to include/linux/elf.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miles Bader <miles@gnu.org>
Cc: Greg Ungerer <gerg@snapgear.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <buoel987otw.fsf_-_@mcspd15.ucom.lsi.nec.co.jp>
References: <buoel987otw.fsf_-_@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 15:41:28 +0000
Message-Id: <1038325289.2594.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 07:49, Miles Bader wrote:
> Hi,
> 
> This patch adds more stuff to include/linux/elf.h for the v850 (used by
> the new module loader).

To save cluttering a linux/*.h file couldnt the module loader for v850 
include an asm/*.h file holding the extra info ?

