Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293592AbSBZMSO>; Tue, 26 Feb 2002 07:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293593AbSBZMSE>; Tue, 26 Feb 2002 07:18:04 -0500
Received: from mtao1.east.cox.net ([68.1.17.244]:50105 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP
	id <S293592AbSBZMSA>; Tue, 26 Feb 2002 07:18:00 -0500
Message-ID: <000501c1bebf$80a3e460$a7eb0544@CX535256D>
From: "Barubary" <barubary@cox.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <006001c1beb9$ea412690$a7eb0544@CX535256D> <3C7B7908.1040508@ellinger.de> <009c01c1bebe$41321730$a7eb0544@CX535256D>
Subject: Change that to an NTFS bug not loopback
Date: Tue, 26 Feb 2002 04:17:04 -0800
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

I tried to mount a 20 meg ISO from an NTFS partition mounted read-only and
it glitched.  It has nothing to do with the size of the file.  I would've
checked smaller files if I had mkisofs handy, which I didn't when I tried
it.

Now I'm afraid that it's a known bug and I've wasted your time... :(

-- Barubary

