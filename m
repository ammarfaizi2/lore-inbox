Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbSKNNg5>; Thu, 14 Nov 2002 08:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSKNNg5>; Thu, 14 Nov 2002 08:36:57 -0500
Received: from [203.124.139.208] ([203.124.139.208]:26669 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id <S262100AbSKNNg5>;
	Thu, 14 Nov 2002 08:36:57 -0500
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Path Name to kdev_t
Date: Thu, 14 Nov 2002 19:19:16 +0530
Message-ID: <000101c28be4$9ff1bf20$e9bba5cc@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In one of the part of my driver module , I have a path name to a device file
(for eg:- /dev/hda1) .Now if I want to obtain the associated major number
and minor number i.e. device ID(kdev_t) of this file what would be the
procedure?

Thanks and Regards
Chandrasekhar

