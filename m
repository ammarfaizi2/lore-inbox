Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132487AbQLQL1r>; Sun, 17 Dec 2000 06:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132536AbQLQL1h>; Sun, 17 Dec 2000 06:27:37 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:4868 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S132487AbQLQL1Z>; Sun, 17 Dec 2000 06:27:25 -0500
Date: Sun, 17 Dec 2000 12:56:56 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001217125656.A309@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 16, 2000 at 07:11:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess the new memory detect does not work correctly with my old work
horse. It is a 100 MHz pentium with 56 Megs RAM. AMIBIOS dated 10/10/94 with
a version number of 51-000-0001169_00111111-101094-SIS550X-H.

2.2.18 reports:
Memory: 55536k/57344k available (624k kernel code, 412k reserved, 732k data, 40k init)

2.2.19pre2 reports:
Memory: 53000k/54784k available (628k kernel code, 408k reserved, 708k data, 40k init)

57344k is 56 Megs which is correct.
54784k is only 53.5 Megs.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
