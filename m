Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSKKAXd>; Sun, 10 Nov 2002 19:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265267AbSKKAXd>; Sun, 10 Nov 2002 19:23:33 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:39388 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265266AbSKKAXc> convert rfc822-to-8bit; Sun, 10 Nov 2002 19:23:32 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Organization: knobisoft.dex
To: linux-kernel@vger.kernel.org
Subject: Memory performance on Serverworks GC-LE based system poor?
Date: Mon, 11 Nov 2002 01:30:13 +0100
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211110130.13943.knobi@knobisoft.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I have experienced extreme low STREAMS numbers (about 600 MB/sec for Triad) 
on two dual CPU systems based on the ServerWorks GC-LE chipset (SuperMicro 
P4DLR+ mainboard). Both systems had 2x2.4 GHz XEONs, 4GB of DDR memory and 
were running kernel 2.4.18. I would usually expect STREAMS numbers of about 
2000 MB/sec for this kind of systems.

Does this ring any bells?

Martin
-- 
----------------------------------
Martin Knoblauch
knobi@knobisoft.de
http://www.knobisoft.de
