Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbRCFTsA>; Tue, 6 Mar 2001 14:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbRCFTrk>; Tue, 6 Mar 2001 14:47:40 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:51903 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S129434AbRCFTrf>;
	Tue, 6 Mar 2001 14:47:35 -0500
Date: Tue, 6 Mar 2001 20:47:03 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: tts/0: 1 input overrun(s)
Message-ID: <Pine.GSO.4.30.0103062043050.2134-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I get the following message:
 tts/0: 1 input overrun(s)

each time while downloading pictures from my digital camera via ttyS0,
_and_ switching between an X session and textmode console.
(ie, 1 switch -> 1 error)

This is with 2.4.1. I don't remember getting these with 2.2
This error also means a transmit error (gphoto reports error and a packet
has to be retransferred.)

What is this? Why I'm getting it? What should I do? :)

bye,
Balazs Pozsar.

