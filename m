Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278592AbRKVNFc>; Thu, 22 Nov 2001 08:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRKVNFW>; Thu, 22 Nov 2001 08:05:22 -0500
Received: from ids.big.univali.br ([200.169.51.11]:5248 "HELO
	mail.big.univali.br") by vger.kernel.org with SMTP
	id <S278592AbRKVNFM>; Thu, 22 Nov 2001 08:05:12 -0500
Message-Id: <5.1.0.14.1.20011122105002.00ab7678@mail.big.univali.br>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 22 Nov 2001 11:04:25 -0200
To: linux-kernel@vger.kernel.org
From: Marcus Grando <marcus@big.univali.br>
Subject: Input/output error
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

After reboot in kernel 2.4.15-pre9 this problem occur:

On try start syslog deamon occur this errrors "Input/output error" on many archives /var directory.

I mount the /var at boot linux single, and when try ls on /var/run list all archives .pid, 
before try ls -la on /var/run, not list all archives.
Try remove .pid archives and the error occur again.

/var partition use ext2

Any suggestion?

Tanks in advance,

Regards
Marcus Grando

	

