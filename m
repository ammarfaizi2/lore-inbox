Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSK0MW4>; Wed, 27 Nov 2002 07:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSK0MW4>; Wed, 27 Nov 2002 07:22:56 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:63124 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262420AbSK0MW4>; Wed, 27 Nov 2002 07:22:56 -0500
Subject: Re: [PATCH]  v850 additions to include/linux/elf.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miles Bader <miles@gnu.org>
Cc: Greg Ungerer <gerg@snapgear.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <buoel97kdx1.fsf@mcspd15.ucom.lsi.nec.co.jp>
References: <buoel987otw.fsf_-_@mcspd15.ucom.lsi.nec.co.jp>
	<1038325289.2594.37.camel@irongate.swansea.linux.org.uk> 
	<buoel97kdx1.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 13:01:35 +0000
Message-Id: <1038402095.6394.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-27 at 01:19, Miles Bader wrote:
> If tidying is needed, then it seems like the best thing would be to move
> all the arch-specific stuff into the corresponding <asm/elf.h> file for
> each architecture.  I presume the reason this hasn't been done is simply
> convention -- userland elf.h files are also giant conglomerations of
> defines for every supported architecture ...

I agree entirely. So lets start with v850 8)

