Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288288AbSAVQRX>; Tue, 22 Jan 2002 11:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSAVQRO>; Tue, 22 Jan 2002 11:17:14 -0500
Received: from [198.17.35.35] ([198.17.35.35]:65471 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S288288AbSAVQRA>;
	Tue, 22 Jan 2002 11:17:00 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2AB7@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Amit Gupta'" <amit.gupta@amd.com>,
        "'Luigi Genoni'" <kernel@Expansa.sns.it>
Cc: linux-kernel@vger.kernel.org,
        "Linux-Net (E-mail)" <linux-net@vger.kernel.org>
Subject: arpx source code released under GPL
Date: Tue, 22 Jan 2002 08:16:52 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FINALLY I have permission to make this available :

Note that I'm not the original author, but I am
maintaining it, so please let me know about any
comments, complaints, patches, flames, whatever.

This is an arpd-replacement daemon that runs under
kernel 2.4.9 without any problems.  I have successfully
had over 2000 entries in the arp cache (from /proc)
with this daemon running.

I haven't done any work on making it good code or work
properly or making sure that it's working the 'right'
way, but it does work and I haven't had any problems
(yet) so feel free to download it, try it out, and
check back to the web page to see any updates as they
become available.

http://home.loran.com/~dlacoste/
