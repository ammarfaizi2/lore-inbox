Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRLBO2x>; Sun, 2 Dec 2001 09:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRLBO2o>; Sun, 2 Dec 2001 09:28:44 -0500
Received: from mail.econophone.ch ([212.53.96.198]:52373 "EHLO econophone.ch")
	by vger.kernel.org with ESMTP id <S279467AbRLBO21>;
	Sun, 2 Dec 2001 09:28:27 -0500
Message-ID: <020801c17b3d$574fbeb0$0501a8c0@llama>
From: "Balazs Javor" <jb3@freemail.hu>
To: "Kernel" <linux-kernel@vger.kernel.org>
Subject: Filesystem corruptions etc. - Which is the last safe kernel?
Date: Sun, 2 Dec 2001 15:26:31 +0100
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

Hi,

I've recently subscribed to this list when someone pointed out on one of the
Debian lists, that the 2.5.15 fs corruption issue
was discussed here much earlier.
Since then I was reading this list with much interest and growing
uncertainty...

It seems to me that every kernel since 2.4.15 had serious problems where
your files can get corrupted / lost.
(Maybe even kernels before that. I just don't know.)

I run a linux machine currently with kernel 2.4.14 at home as a fileserver
where I keep all my personal files etc. on to
80GB harddrives.
I am a little bit nervouse, though...

I thought the even numbered kernel releases like 2.4.x are safe to be used,
without the risk of major data loss etc.!!!
It seems to me less and less so.

I was also eagerly waiting for the ext3 fs to be included in the kernel for
the same concern, especially that while trying to set up XFree
I often encounter complete lockups where only a hard reset helps :(
Unfortunatly I'm a bit afraid to install any kernel that inlcudes it since
they seem to cause more problems then they solve.

Now the question is, is any of the 2.4.x kernels safe to use?
And why is it that supposedly released and stable kernels can have such
serious issues?

Many thanks in advance!
best regards,
Balazs


