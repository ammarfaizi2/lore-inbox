Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291485AbSBRKzE>; Mon, 18 Feb 2002 05:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310424AbSBRKyz>; Mon, 18 Feb 2002 05:54:55 -0500
Received: from mailhost.cs.tamu.edu ([128.194.130.106]:15863 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S291485AbSBRKyt>;
	Mon, 18 Feb 2002 05:54:49 -0500
Date: Mon, 18 Feb 2002 04:54:41 -0600 (CST)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: linux-kernel@vger.kernel.org
Subject: weird ip sequence number
Message-ID: <Pine.SOL.4.10.10202180439080.14846-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Really weird!

	I have two linux machines with kernel 2.4.17. When I ping one
machine from the other machine, all the ping request ip packets have the
same sequnce number 0. The ping reply packets have different ip
sequence numbers. Moreover, when I send udp packets using general
socket programming, all the udp packets have the same sequence number 0.

	I use ethereal to check the packets.

	What's the problem?

	Thanks!



Xinwen Fu


