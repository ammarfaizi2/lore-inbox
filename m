Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <160397-26601>; Wed, 21 Oct 1998 15:59:29 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:11046 "HELO mail.ocs.com.au" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <160721-26601>; Wed, 21 Oct 1998 15:10:04 -0400
Message-ID: <19981022014931.3289.qmail@mail.ocs.com.au>
From: Keith Owens <kaos@ocs.com.au>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.rutgers.edu
Subject: Re: New ksymoops that handles modules (was Re: How to translate an oops) 
In-reply-to: Your message of "Wed, 21 Oct 1998 19:39:41 +0200." <UTC199810211739.TAA34047.aeb@texel.cwi.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Oct 1998 11:49:26 +1000
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, 21 Oct 1998 19:39:41 +0200 (MET DST), 
Andries.Brouwer@cwi.nl wrote:
>EIP:    0030:0011127c 
>EFLAGS: 00000246
>eax: 0000000d 
>ebx: 00ef2018 
>ecx: 0000000d 
>edx: 001fd434 
>esi: 011da830 
>edi: 011da830 
>ebp: 00efbfa8 <%esp+28>
>esp: 00efbf80 <%esp+0>
>ds: 0018   es: 0038   fs: 002b   gs: 002b   ss: 0018
>Process runslip (pid: 48, process nr: 18, stackpage=00efb000)
>esp+00: 00002000 
>esp+04: 00efbfbc <%esp+3c>
>...
>Trace: 001e002b 
>Trace: 02800000 
>Trace: 03000000 
>Trace: 02800000 
>Trace: 0010b3bd 
>Trace: 0010b380 
>Trace: 0010ac70 
>Trace: 0011127c 
>Trace: 0010a254 
>Trace: 0010aae5 
>Code: 0010b069:
>----------------------------------------------------------

Send me the Oops file please, I make sure it is handled.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
