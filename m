Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312052AbSCQPPA>; Sun, 17 Mar 2002 10:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312051AbSCQPOl>; Sun, 17 Mar 2002 10:14:41 -0500
Received: from mail020.mail.bellsouth.net ([205.152.58.60]:12231 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S312049AbSCQPOc>; Sun, 17 Mar 2002 10:14:32 -0500
Message-ID: <005301c1cdc6$5a26de80$0100a8c0@DELLXP1>
From: "Ken Hirsch" <kenhirsch@myself.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
In-Reply-To: <3C945635.4050101@mandrakesoft.com>
Subject: Re: fadvise syscall?
Date: Sun, 17 Mar 2002 10:13:45 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a posix_fadvise() syscall in the POSIX Advanced Realtime
specification
http://www.opengroup.org/onlinepubs/007904975/functions/posix_fadvise.html


I don't know if this has been mentioned on linux-kernel before, but in
January, the Open Group, in cooperation with IEEE, added the POSIX
functionality to their specification and made it available online for free.
It's at
http://www.opengroup.org/onlinepubs/007904975/toc.htm

There are some useful tables at
http://www.unix-systems.org/version3/online.html and they ask that you
register there so that they know how many people are using the
specification.

They don't have a downloadable version of this specification, but they do
for the previous versions:
http://www.opengroup.org/onlinepubs/007908799/download/

Ken Hirsch



