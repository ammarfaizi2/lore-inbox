Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265467AbSJSCB1>; Fri, 18 Oct 2002 22:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265471AbSJSCB1>; Fri, 18 Oct 2002 22:01:27 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:3603 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265467AbSJSCBZ>;
	Fri, 18 Oct 2002 22:01:25 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Exploit for the Kernel 
In-reply-to: Your message of "Fri, 18 Oct 2002 18:51:16 MST."
             <20021018.185116.128890469.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Oct 2002 12:07:10 +1000
Message-ID: <4105.1034993230@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002 18:51:16 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>   From: "Breno" <breno_silva@bandnet.com.br>
>   Date: Fri, 18 Oct 2002 22:42:12 -0300
>
>   http://online.securityfocus.com/archive/1/295855/2002-10-15/2002-10-21/1 
>   
>There is nothing concrete at all about said "exploit".
>
>It looks like just a clever way to divert the victim's
>attention from the real mechanism these guys are using
>to root peoples boxes.

Agreed.

>It is nearly impossible for a TCP frag handling exploit
>to allow a root shell and socket to that shell to be
>created.  So I think the claims are total nonsense.

The last mail on that thread is interesting[*], fooling the victim into
running a vulnerable version of tcpdump by claiming a vulnerability in
TCP.

[*] http://online.securityfocus.com/archive/1/295855/2002-10-15/2002-10-21/2

