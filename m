Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266720AbSLPNgN>; Mon, 16 Dec 2002 08:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266721AbSLPNgM>; Mon, 16 Dec 2002 08:36:12 -0500
Received: from smtp-01.inode.at ([62.99.194.3]:8429 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S266720AbSLPNgM> convert rfc822-to-8bit;
	Mon, 16 Dec 2002 08:36:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Patrick Petermair <black666@inode.at>
Reply-To: black666@inode.at
To: linux-kernel@vger.kernel.org
Subject: Re: IDE-CD and VT8235 issue!!!
Date: Mon, 16 Dec 2002 14:45:34 +0100
User-Agent: KMail/1.4.3
References: <3DFB7B21.7040004@tin.it> <200212152256.25266.black666@inode.at> <20021216113458.A31837@ucw.cz>
In-Reply-To: <20021216113458.A31837@ucw.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212161445.34087.black666@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik:

> If you can, please try 2.4.20 with this patch.

Wow, that was fast.

The patch works perfect. The kernel boots with no problem, I have dma on 
all my disk AND I can mount a CD/DVD without any problems.
Would be cool to see this patch included in the 2.4.21 kernel.

Thanks,
Patrick



