Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSC0U6T>; Wed, 27 Mar 2002 15:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSC0U6K>; Wed, 27 Mar 2002 15:58:10 -0500
Received: from cambot.suite224.net ([209.176.64.2]:60430 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S291547AbSC0U6C>;
	Wed, 27 Mar 2002 15:58:02 -0500
Message-ID: <003e01c1d5d2$b62f82e0$b0d3fea9@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <linux-kernel@vger.kernel.org>
Subject: (RFC)Supermount 2
Date: Wed, 27 Mar 2002 16:02:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fellow Linux Hackers.

I am starting to plan a new version of Supermount. I have some things I want
to try out in it, and I will list them in this message. I am willing to
accept any and all input on what I am wanting to call Supermount 2.

Planned features of Supermount 2:

1) Auto-detection of filesystem type.

2) Supermount modules for each filesystem type.

3) Built-in support for packet-writing. ( i.e. insert packet-writing
formatted disk and it loads appropriate kernel modules. )

There may be other features added if there is an interest in them. I will
need assistance with the packet-writing support. I am only planning to do
this for the 2.5.x and later kernels, so if anyone else wishes to back-port
it to an older kerenl series, by all means do so. I have wanted to make some
kind of contribution to this project for some time and I feel that this is
something that will be useful.

I am going to be making my prelminary code available to whomever wishes to
see it once I get my Linux box back up.

Matthew D. Pitts

