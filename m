Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbTAEUcA>; Sun, 5 Jan 2003 15:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbTAEUb7>; Sun, 5 Jan 2003 15:31:59 -0500
Received: from mail.hometree.net ([212.34.181.120]:27284 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265108AbTAEUb5>; Sun, 5 Jan 2003 15:31:57 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Date: Sun, 5 Jan 2003 20:40:32 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ava580$g2a$1@forge.intermeta.de>
References: <20030102013736.GA2708@gnuppy.monkey.org> <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org> <20030102055859.GA3991@gnuppy.monkey.org> <20030102061430.GA23276@mark.mielke.cc> <E18UIZS-0006Cr-00@fencepost.gnu.org> <20030103040612.GA10651@work.bitmover.com> <20030104220651.GA30907@merlin.emma.line.org> <20030104222330.GA1386@work.bitmover.com> <20030105101413.GC14362@louise.pinerecords.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1041799232 22430 212.34.181.4 (5 Jan 2003 20:40:32 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 5 Jan 2003 20:40:32 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> writes:

>Even if I overlook that you're effectively comparing the incomparable,
>Microsoft making 370 times more than RedHat says _nothing_ about their
>actual achievement in terms of software development.  Should you insist

You might simply open your eyes and look around you before you utter
such ridicioulous statements.

% cd /home/mirror/RFC
% for i in rfc*.txt; do head -20 $i | grep -iq microsoft; if [ "x$?" = "x0" ]; then    echo $i; fi; done | wc -l
    102     102    1224 /tmp/rfc-log
% for i in rfc*.txt; do head -20 $i | grep -iq 'red hat'; if [ "x$?" = "x0" ]; then    echo $i; fi; done | wc -l
% for i in rfc*.txt; do head -20 $i | grep -iq 'redhat'; if [ "x$?" = "x0" ]; then    echo $i; fi; done | wc -l


So in terms of "RFC contributions" which are the established and
accepted base on which to build the internet and "open software", the
score is

Microsoft Corporation vs. Red Hat Inc.
    102                :    0

Some examples: 

rfc1877:	PPP Internet Protocol Control Protocol Extensions for Name Server Addresses
rfc2069/2617:	An Extension to HTTP : Digest Access Authentication
rfc2193:	IMAP4 Mailbox Referrals
rfc2237:	Japanese Character Encoding for Internet Messages
rfc2338:	Virtual Router Redundancy Protocol
rfc2342:	IMAP4 Namespace
rfc2445:	Internet Calendaring and Scheduling Core Object Specification (iCalendar)
rfc2518/3253:	HTTP Extensions for Distributed Authoring -- WEBDAV
rfc2565:	Internet Printing Protocol/1.0: Encoding and Transport
rfc2616:	Hypertext Transfer Protocol -- HTTP/1.1 	(Yup. Microsoft)
rfc2661:	Layer Two Tunneling Protocol "L2TP"
rfc2782:	A DNS RR for specifying the location of services (DNS SRV)
rfc2989:	Criteria for Evaluating AAA Protocols for Network Access (Microsoft. Sun. Cisco. Nokia.)


	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
