Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285438AbRLNRlT>; Fri, 14 Dec 2001 12:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285440AbRLNRlK>; Fri, 14 Dec 2001 12:41:10 -0500
Received: from outbound.ea.com ([12.35.91.3]:35745 "EHLO outbound.ea.com")
	by vger.kernel.org with ESMTP id <S285438AbRLNRlA>;
	Fri, 14 Dec 2001 12:41:00 -0500
Date: Fri, 14 Dec 2001 17:40:38 UTC
From: Thomas Schenk <tschenk@origin.ea.com>
Reply-To: tschenk@origin.ea.com
Subject: Question regarding limit on the number of sockets?
To: linux-kernel@vger.kernel.org
Message-ID: <INSIGHT.2.6.Linux-2.4.16.01121411403821.24988@bagend.origin.ea.com>
Organization: EA.com Austin
X-Mailer: INSIGHT 2.6 [en_US] Linux 2.4.16
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-Accept-Language: en_US
Sensitivity: Public-Document
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize if this is a FAQ, but I have not been able to find the
answer to a question that was asked of me.  According to the person who
asked, there is a limit on the number of sockets that can be open at a
given time.  The person stated that this limit was 1024.  My questions
are:

1.  Is this a per process limit, a per user limit, or a system wide
limit?
2.  Does this limit apply to both the 2.2.x and 2.4.x kernels?
3.  Is this limit tunable (either by patching the kernel or otherwise)?

I wouldn't bother asking here, but I need an answer quickly for my boss
and thus far, my searching has not turned up the answer.

Thanks in advance for any help that you can provide me.

Tom Schenk
Online Operations
EA.COM

   +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
   | Tom Schenk            | A positive attitude may not solve all your    |
   | Online Ops, EA.COM    | problems, but it will annoy enough people to  |
   | tschenk@origin.ea.com | make it worth the effort. -- Herm Albright    |
   +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

