Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264550AbRFMGR6>; Wed, 13 Jun 2001 02:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264551AbRFMGRs>; Wed, 13 Jun 2001 02:17:48 -0400
Received: from smtp-server1.cfl.rr.com ([65.32.2.68]:40680 "EHLO
	smtp-server1.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S264550AbRFMGRj>; Wed, 13 Jun 2001 02:17:39 -0400
Subject: Lockups w/ VIA KT133A board
From: Gerard Daubar <gerard@idita.com>
To: linux-kernel@vger.kernel.org
Cc: gerard@idita.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 13 Jun 2001 02:17:24 -0400
Message-Id: <992413045.966.0.camel@24161241hfc233.tampabay.rr.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
(Please CC gerard@idita.com as I'm
not on the list)

I'm getting lockups when I try to
use my cd burner (SCSI burner).
Using an Asus A7V133 motherboard
that uses the VIA KT133A chipset
(using an Athlon 1.2ghz). I've
scanned the archives and see issues
with people using the udma/100 ide
controller and what not but I'm not
using IDE here (tested with 2.4.1,
2.4.3, 2.4.4, 2.4.5).It locks up
solid everytime as writing begins
(using cdrecord) and I'm unable do
SysRq. 

I've also had some random lock-ups
while xscreensaver is running that
also lock the machine solid (scsi
harddisks.. again, not IDE). Is the
VIA chipset to blame for all this
even though they're not IDE
problems? If so anyone recommend a
chipset that will 'work'... or even
a motherboard.

thanks kindly,
Gerard



