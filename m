Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131348AbRDBMNk>; Mon, 2 Apr 2001 08:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131489AbRDBMNa>; Mon, 2 Apr 2001 08:13:30 -0400
Received: from dns.ipv6.univ-nantes.fr ([193.52.101.20]:51472 "HELO
	popeye.ipv6.univ-nantes.fr") by vger.kernel.org with SMTP
	id <S131348AbRDBMNW>; Mon, 2 Apr 2001 08:13:22 -0400
Subject: Oracle 8I & Kernel 2.4.3 : Sane ?
From: Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10+cvs.2001.04.01.08.00 (Preview Release)
Date: 02 Apr 2001 14:12:40 +0200
Message-Id: <986213560.24497.2.camel@olive>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. Some times ago, I tried Kernel 2.4.2 with oracle 8i 
(old version, 8.1.5)

Oracle was working fine at start, but after some hours we encountered
problems (I'm not database guru, I'm not able to say what was really not
working, it seems like a "rollback segment" was unable to be modified /
stuck)

I noticed that 2.4.3 contains some fixs for shared memory -
So the final question IS :

Is oracle 8.1.5 + Kernel 2.4.3 a sane combination ?
In general is oracle + Kernel 2.4 working ? 

(BTW, if that matter this is on a 4-xeon Proc + 3GB ram)

Yann Dupont.
-- 
\|/ ____ \|/ Fac. des sciences de Nantes-Linux-Python-IPv6-ATM-BONOM....
"@'/ ,. \@"  Tel :(+33) [0]251125865(AM)[0]251125857(PM)[0]251125868(Fax)
/_| \__/ |_\ Yann.Dupont@sciences.univ-nantes.fr
   \__U_/    http://www.unantes.univ-nantes.fr/~dupont

