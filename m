Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRFJVqu>; Sun, 10 Jun 2001 17:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262629AbRFJVqk>; Sun, 10 Jun 2001 17:46:40 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:53680 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262355AbRFJVqe>; Sun, 10 Jun 2001 17:46:34 -0400
Message-ID: <001f01c0f1f6$b6bc0c80$0a01a8c0@w98>
From: "Rose, Daniel" <daniel.rose@datalinesolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: pppd in 2.4 series
Date: Sun, 10 Jun 2001 17:45:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have lots of problems w/ the 2.4 series and PPP..
Everything compiles fine, and boots fine, but try and run pppd, and "This
kernel as no support of PPP.."
PPP is shown in dmesg:

PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered

I had this problem 2.4.5 earlier, but it went away when i applied Alans ac9
patch, but now the problem seems to stay, and I am quite stuck.


