Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRDWGYA>; Mon, 23 Apr 2001 02:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbRDWGXu>; Mon, 23 Apr 2001 02:23:50 -0400
Received: from mr.tuwien.ac.at ([128.130.2.10]:41699 "EHLO mr.tuwien.ac.at")
	by vger.kernel.org with ESMTP id <S131344AbRDWGXh>;
	Mon, 23 Apr 2001 02:23:37 -0400
From: Norbert Preining <preining@logic.at>
Date: Mon, 23 Apr 2001 08:22:40 +0200
To: Mark Swanson <swansma@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALI 1541,K6,AGP 2.4.3-ac12 instability
Message-ID: <20010423082240.A661@mandala.telekabel.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark!

This is a well known problem. nvidia-0.9-769 does NOT WORK WITH
2.4.X agpgart, either use nvagp (not possible for ali chipsets)
or disable agp (Option "NvAgp" "0") for the time being.

Next version will hopefully fix this!

See #nvidia on openprojects.net

Best wishes

Norbert

-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+
