Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282862AbRLLXIe>; Wed, 12 Dec 2001 18:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282867AbRLLXIX>; Wed, 12 Dec 2001 18:08:23 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:22687 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S282862AbRLLXIP>;
	Wed, 12 Dec 2001 18:08:15 -0500
Date: Thu, 13 Dec 2001 00:08:08 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Unknown bridge resource
Message-ID: <Pine.GSO.4.30.0112130004310.5686-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

During boot, i got these two lines in dmesg:
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent

What do they mean?


ps: I noticed these because they are written on the console even if quiet
mode is on. There was a patch for 2.4-ac, but it seems that it somehow
lost... :(

-- 
Balazs Pozsar

