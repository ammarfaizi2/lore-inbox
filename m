Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262255AbTCHVit>; Sat, 8 Mar 2003 16:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTCHVit>; Sat, 8 Mar 2003 16:38:49 -0500
Received: from crete.csd.uch.gr ([147.52.16.2]:3057 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id <S262255AbTCHVis>;
	Sat, 8 Mar 2003 16:38:48 -0500
Organization: 
Date: Sat, 8 Mar 2003 23:49:12 +0200 (EET)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: linux-kernel@vger.kernel.org
Subject: Promise TX2-Ultra100 PDC20268 lockups
Message-ID: <Pine.GSO.4.53.0303082338030.4596@oneiro.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried 2.4.21-pre5, 2.4.21-pre5-ac1, 2.4.21-pre5-ac2, linux-2.5.64
but with all of them I get hard lockups if I have dma enabled.
Even if I just play mp3s which do not put the controller in a hard time,
after a while my system will lockup. Can anyone help?

	Panagiotis Papadakos
