Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286323AbRL0QBm>; Thu, 27 Dec 2001 11:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286321AbRL0QBc>; Thu, 27 Dec 2001 11:01:32 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:33804 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S286322AbRL0QB3>; Thu, 27 Dec 2001 11:01:29 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Holzer Harald" <hholzer@may.co.at>, <linux-kernel@vger.kernel.org>
Subject: RE: Out of Memory at 20GB of free memory ??
Date: Thu, 27 Dec 2001 08:01:29 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBOEMCEEAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <90B53A874299D411810500D0B7892DDA068084@srv3.intern.may.co.at>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm ... clearly you must be using the 64 GB memory model ... lucky guy ...
my 512 MB single-processor Athlon is insanely jealous :). And you have 20 GB
free. So the system must be out of memory either under 1 GB or under 4 GB
for some purpose that requires a 32 bit (4 GB) address or a 30 bit (1 GB)
address. Hmmm again ... are there practical limits to what one can do with
memory over 4 GB even with PAE? Or is this just a bug in the 64 GB model?
--
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

