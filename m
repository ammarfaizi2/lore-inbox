Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbQJ0US6>; Fri, 27 Oct 2000 16:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbQJ0USi>; Fri, 27 Oct 2000 16:18:38 -0400
Received: from balin.ap.univie.ac.at ([131.130.11.50]:10500 "EHLO
	balin.ap.univie.ac.at") by vger.kernel.org with ESMTP
	id <S129536AbQJ0US3>; Fri, 27 Oct 2000 16:18:29 -0400
Date: Fri, 27 Oct 2000 22:18:27 +0200 (MET DST)
From: Ulrich Kiermayr <uk@ap.univie.ac.at>
To: linux-kernel@vger.kernel.org
Subject: netscape and 2.2.18pre1[67] alpha
Message-ID: <Pine.OSF.4.21.0010272213410.25459-100000@balin.ap.univie.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have a problem with netscape 4.75 under RH6.2 with a  2.2.18pre1[67].

running it as root wirks fine, running it as ordinary user hangs very
fast.

The logs show several 

Oct 27 21:29:25 guinevere kernel: <sc 0(84,c8,11ffffa78)><sc
53(8,c8,11ffffa78)><sc 0(17,336,11ffffa78)><sc
53(8,336,11ffffa78)>set_program_attributes(12000000 d98000 14000000
457440)

messages

I have tried this on 2 different Alpha-Types (Avanti, SX164) with several
tifferent compiling-options, bon without success.

Any suggestions how I can make netscape and maybe other Tru64 Binaries
work properly, since the alphas are in a cluster  with some Tru64 servers?

LL&P UK
-- 
===============================================================================
Ulrich Kiermayr                    | Internet eMail:
Zentraler Informatikdienst der     |      ulrich.kiermayr@ap.univie.ac.at
Universitaet Wien                  |      ulrich.kiermayr@univie.ac.at
                                   | ------------------------------------------
   Abteilung Dezentrale Systeme    | eMail Hotline-Service:
   Aussenstelle Physik             |      hotline@ap.univie.ac.at
                                   | ------------------------------------------
Boltzmanngasse 5, A-1090 Vienna    | Tel: +43-1-4277 /14104,    Hotline: /14100
Austria, Europe                    | Fax: +43-1-4277 /9141
===============================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
