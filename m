Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130902AbRAXS3F>; Wed, 24 Jan 2001 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131568AbRAXS24>; Wed, 24 Jan 2001 13:28:56 -0500
Received: from d1c4544d.dfw14.dsl.airmail.net ([209.196.84.77]:10252 "EHLO
	slowpoke.i-vic.net") by vger.kernel.org with ESMTP
	id <S130902AbRAXS2d>; Wed, 24 Jan 2001 13:28:33 -0500
From: Brad Felmey <bradf@i-vic.net>
To: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat <-> vfat copying of ~700MB file, so slow!
Date: Wed, 24 Jan 2001 12:23:03 -0600
Organization: i-VIC Corp.
Message-ID: <997u6tsn18dp9u1h97q4j5jc9a2amn1nsp@i-vic.net>
In-Reply-To: <20010124131431.A19957@ikar.t17.ds.pwr.wroc.pl>
In-Reply-To: <20010124131431.A19957@ikar.t17.ds.pwr.wroc.pl>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001 13:14:31 +0100, you, Arkadiusz Miskiewicz
<misiek@pld.ORG.PL>, wrote:

> I/O support  =  0 (default 16-bit)

hdparm -c1 /dev/hda, or are you running in 16-bit mode on purpose?
--
Brad Felmey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
