Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289190AbSAVHr3>; Tue, 22 Jan 2002 02:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289195AbSAVHrU>; Tue, 22 Jan 2002 02:47:20 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:15564 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289190AbSAVHrH>; Tue, 22 Jan 2002 02:47:07 -0500
Date: Tue, 22 Jan 2002 09:43:29 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: dwmw2@infradead.org
Cc: velco@fadata.bg, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __linux__ and cross-compile 
Message-ID: <Pine.LNX.4.44.0201220939510.17842-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We think *BSD uses _KERNEL, and don't know of anything else which defines 
>__KERNEL__ other than Linux. So he's switching from something that's known 
>broken to something which we _believe_ will be reliable.

I agree, frankly i don't think anyone should touch this particular code 
(aic7xx) unless they also build and test on the other target platforms. 
Was this cleanup cc'd to Justin Gibbs? What did he have to say about it?

Regards,
	Zwane Mwaikamob


