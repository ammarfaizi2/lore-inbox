Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264038AbRFFSqO>; Wed, 6 Jun 2001 14:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264027AbRFFSqE>; Wed, 6 Jun 2001 14:46:04 -0400
Received: from comverse-in.com ([38.150.222.2]:64402 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S264035AbRFFSpy>; Wed, 6 Jun 2001 14:45:54 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678F26@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Adam'" <adam@cfar.umd.edu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: ethernet and pointopoint
Date: Wed, 6 Jun 2001 14:44:54 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Adam [mailto:adam@cfar.umd.edu]
> 	Is there reason why I can't set pointopoint for ethernet? I have

If your network cards & their drivers (both hosts) support full duplex
operation,
just enable it, and you're done.

V.

