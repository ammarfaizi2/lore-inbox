Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131433AbQLZQl7>; Tue, 26 Dec 2000 11:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131616AbQLZQlt>; Tue, 26 Dec 2000 11:41:49 -0500
Received: from atlantis.hlfl.org ([213.41.91.231]:4362 "HELO atlantis.hlfl.org")
	by vger.kernel.org with SMTP id <S131433AbQLZQlg>;
	Tue, 26 Dec 2000 11:41:36 -0500
Date: Tue, 26 Dec 2000 17:11:09 +0100
From: "Arnaud S . Launay" <asl@launay.org>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Athlon CPU [long]
Message-ID: <20001226171108.A55912@profile4u.com>
Mail-Followup-To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0012051135361.1881-200000@lt.wsisiz.edu.pl> <Pine.LNX.4.30.0012050613240.620-100000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012050613240.620-100000@asdf.capslock.lan>; from mharris@opensourceadvocate.org on Tue, Dec 05, 2000 at 06:17:39AM -0500
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Dec 05, 2000 at 06:17:39AM -0500, Mike A. Harris a écrit:
> >kgcc: Internal compiler error: program cpp got fatal signal 11
> Sig11 generally indicates bad RAM or overheating or some faulty
> hardware.  This is an FAQ. Read the lkml FAQ.

Once upon a time, it was also buggy k6... check with memtest
(http://reality.sgi.com/cbrady_denver/memtest86/)

	Arnaud.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
