Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289208AbSBDWMP>; Mon, 4 Feb 2002 17:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289201AbSBDWMB>; Mon, 4 Feb 2002 17:12:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23312 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289198AbSBDWLt>; Mon, 4 Feb 2002 17:11:49 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to check the kernel compile options ?
Date: 4 Feb 2002 14:11:26 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3n0ue$gat$1@cesium.transmeta.com>
In-Reply-To: <E16XmqC-0007lb-00@the-village.bc.nu> <E16XnUr-0004mf-00@starship.berlin> <3C5ECF8C.1744549C@redhat.com> <E16Xnn7-0004mp-00@starship.berlin>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16Xnn7-0004mp-00@starship.berlin>
By author:    Daniel Phillips <phillips@bonn-fries.net>
In newsgroup: linux.dev.kernel
> > 
> > It's silly to put it permanently in unswappable memory; putting it in 
> > /lib/modules/`uname -r/
> > somewhere does make tons of sense instead.
> 
> Could you show me where I suggested putting it "permanently in unswappable memory"?
> 

You suggested putting it in the kernel, which is permanently in
unswappable memory.  Using a module is, as I pointed out earlier,
worse than useless.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
