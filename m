Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130109AbQK1JBI>; Tue, 28 Nov 2000 04:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130379AbQK1JA6>; Tue, 28 Nov 2000 04:00:58 -0500
Received: from nread2.inwind.it ([212.141.53.75]:17818 "EHLO relay4.inwind.it")
        by vger.kernel.org with ESMTP id <S130109AbQK1JAl>;
        Tue, 28 Nov 2000 04:00:41 -0500
Date: Tue, 28 Nov 2000 10:33:53 +0100
From: Gianluca Anzolin <g.anzolin@inwind.it>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: console not working in linux
Message-ID: <20001128103352.A377@fourier.home.intranet>
In-Reply-To: <E140Pc3-0003AI-00@the-village.bc.nu> <200011271849.eARInfc255418@saturn.cs.uml.edu> <8vubeq$r5r$1@cesium.transmeta.com> <20001128011613.A317@fourier.home.intranet> <3A22EF3D.B97A0965@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A22EF3D.B97A0965@transmeta.com>; from hpa@transmeta.com on Mon, Nov 27, 2000 at 03:33:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

|No, the problem is the utterly braindamaged way the motherboard chose to
|enable/disable it (*especially* if it's PCI... sheech, port 92h isn't
|exactly something new in that timeframe.)
|
|What PC/motherboard is this, anyway?

It's an olivetti, but maybe they bought the mainboard elsewhere I don't
know. Anyway you can find the lspci -xvv in
http://www.gest.unipd.it/~iig0573/lspci.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
