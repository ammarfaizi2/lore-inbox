Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbTAFU5Z>; Mon, 6 Jan 2003 15:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267139AbTAFU5Z>; Mon, 6 Jan 2003 15:57:25 -0500
Received: from mail5.intermedia.net ([206.40.48.155]:44050 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id <S267128AbTAFU5W>; Mon, 6 Jan 2003 15:57:22 -0500
From: "Ranjeet Shetye" <ranjeet.shetye@zultys.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Why is Nvidia given GPL'd code to use in closed source drivers?
Date: Mon, 6 Jan 2003 13:05:59 -0800
Message-ID: <015401c2b5c7$6a088da0$0100a8c0@zultys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <ava580$g2a$1@forge.intermeta.de>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Five years back, when I was working on IPSec, MS wanted to subvert IPSec
deployment; replace it with L2TP (PPTP + L2F). I almost thought that
their IPSec clients were purposely and "randomly" faulty when it come to
interoperability. Drove the rest of us nuts while I guess their minions
in redmond were working on the real version of the ipsec client. That's
how unappetizing any interaction with MS was.

MS might have their names in the RFCs; doesn't mean that they really
contribute positively to the community.

Ranjeet Shetye
Senior Software Engineer

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Henning P. Schmiedehausen
> Sent: Sunday, January 05, 2003 12:41 PM
> To: linux-kernel@vger.kernel.org
> Subject: Re: Why is Nvidia given GPL'd code to use in closed 
> source drivers?
> 
> 
> Tomas Szepe <szepe@pinerecords.com> writes:
> 
> >Even if I overlook that you're effectively comparing the 
> incomparable, 
> >Microsoft making 370 times more than RedHat says _nothing_ 
> about their 
> >actual achievement in terms of software development.  Should 
> you insist
> 
> You might simply open your eyes and look around you before 
> you utter such ridicioulous statements.
> 
> % cd /home/mirror/RFC
> % for i in rfc*.txt; do head -20 $i | grep -iq microsoft; if 
> [ "x$?" = "x0" ]; then    echo $i; fi; done | wc -l
>     102     102    1224 /tmp/rfc-log
> % for i in rfc*.txt; do head -20 $i | grep -iq 'red hat'; if 
> [ "x$?" = "x0" ]; then    echo $i; fi; done | wc -l
> % for i in rfc*.txt; do head -20 $i | grep -iq 'redhat'; if [ 
> "x$?" = "x0" ]; then    echo $i; fi; done | wc -l
> 
> 
> So in terms of "RFC contributions" which are the established 
> and accepted base on which to build the internet and "open 
> software", the score is
> 
> Microsoft Corporation vs. Red Hat Inc.
>     102                :    0
> 
> Some examples: 
> 
> rfc1877:	PPP Internet Protocol Control Protocol 
> Extensions for Name Server Addresses
> rfc2069/2617:	An Extension to HTTP : Digest Access Authentication
> rfc2193:	IMAP4 Mailbox Referrals
> rfc2237:	Japanese Character Encoding for Internet Messages
> rfc2338:	Virtual Router Redundancy Protocol
> rfc2342:	IMAP4 Namespace
> rfc2445:	Internet Calendaring and Scheduling Core Object 
> Specification (iCalendar)
> rfc2518/3253:	HTTP Extensions for Distributed Authoring -- WEBDAV
> rfc2565:	Internet Printing Protocol/1.0: Encoding and Transport
> rfc2616:	Hypertext Transfer Protocol -- HTTP/1.1 	
> (Yup. Microsoft)
> rfc2661:	Layer Two Tunneling Protocol "L2TP"
> rfc2782:	A DNS RR for specifying the location of 
> services (DNS SRV)
> rfc2989:	Criteria for Evaluating AAA Protocols for 
> Network Access (Microsoft. Sun. Cisco. Nokia.)
> 
> 
> 	Regards
> 		Henning
> 
> 
> -- 
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- 
> Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
> 
> Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> D-91054 Buckenhof     Fax.: 09131 / 50654-20   
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

