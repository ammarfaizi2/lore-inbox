Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbSLNUVj>; Sat, 14 Dec 2002 15:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSLNUVj>; Sat, 14 Dec 2002 15:21:39 -0500
Received: from neouvielle.enseirb.fr ([147.210.18.138]:40084 "EHLO
	neouvielle.enseirb.fr") by vger.kernel.org with ESMTP
	id <S265890AbSLNUVi>; Sat, 14 Dec 2002 15:21:38 -0500
Date: Sat, 14 Dec 2002 22:28:16 +0100
From: Sapan Bhatia <bhatia@enseirb.fr>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, reveillere@enseirb.fr
Subject: MCE 7 / Athlon / 2.4.20
Message-ID: <20021214222816.A487@enseirb.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux philemon 2.5.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using a Compaq Evo N1005v: Athlon 1.5GHz/256MB RAM.
I get the following MCE when trying to boot 2.4.20, followed by a kernel
panic:

MCE 7
Bank: 3
Code: b40000000000083b 
Addr: 00000001fc0003b3

I tried using your decoder (parsmec.c) but to no avail...

Regards,
Sapan
