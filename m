Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbSLXCSN>; Mon, 23 Dec 2002 21:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSLXCSN>; Mon, 23 Dec 2002 21:18:13 -0500
Received: from Panther.CS.UCLA.EDU ([131.179.128.25]:41668 "EHLO
	panther.cs.ucla.edu") by vger.kernel.org with ESMTP
	id <S267034AbSLXCSN>; Mon, 23 Dec 2002 21:18:13 -0500
Date: Mon, 23 Dec 2002 18:26:18 -0800 (PST)
From: Jelena Mirkovic <sunshine@CS.UCLA.EDU>
To: <linux-kernel@vger.kernel.org>
Subject: Create and send packet from kernel 
Message-ID: <Pine.SOL.4.33.0212231808170.18050-100000@panther.cs.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying (in vain) to create and send a single TCP packet from kernel,
from scratch (i.e. sk_buff and sock both need to be created and
initialized). I read the source code for various functions in net and
net/ipv4 but I am not sure I am doing all steps and in correct order, as
the kernel keeps crashing. Is there a sample code someone could send me or
a good book on this matter? I am using 2.4.9 version.

If this question is not appropriate for this list, could someone point me
to more suitable list?

Thanks
Jelena

