Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbQLaELD>; Sat, 30 Dec 2000 23:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQLaEKm>; Sat, 30 Dec 2000 23:10:42 -0500
Received: from mail11.verio.de ([213.198.0.60]:22625 "HELO mail11.verio.de")
	by vger.kernel.org with SMTP id <S129436AbQLaEKl>;
	Sat, 30 Dec 2000 23:10:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michael Meding <Michael@Meding.net>
Reply-To: Michael@Meding.net
To: linux-kernel@vger.kernel.org
Subject: is there something odd in the aic7xxx driver ?
Date: Sun, 31 Dec 2000 04:32:10 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <00123104321002.00349@Hal>
Content-Transfer-Encoding: 7BIT
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am experiencing problem with the latest test kernels and my adaptec 2940uw 
and one ibm hdd.

Thing is that during times the machine simply reboots without apparent 
reasons. Nothing shows up, to my knowledge in /var/log or other places. This 
is with the kernel compiled with gcc 2.95.2 on debian woody.

Using Gibbs respectively the adaptec driver I haven't had this behaviour in 
weeks, or better to say, not once.

The machine is up 24/7 but not under very high load. The times it failed have 
mostly been under more or less heavy i/o like compiling several kernels at a 
time.

Are others experiencing similar behaviours ?

Greetings

Michael Meding



System is kt-133 with mga g400, duron800 adaptec 2940uw with latest bios. 
Further information upon request.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
