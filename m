Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSLIJQ5>; Mon, 9 Dec 2002 04:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSLIJQ4>; Mon, 9 Dec 2002 04:16:56 -0500
Received: from [213.171.53.133] ([213.171.53.133]:35083 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S264867AbSLIJQ4>;
	Mon, 9 Dec 2002 04:16:56 -0500
Date: Mon, 9 Dec 2002 10:01:29 +0300
From: Samium Gromoff <deepfire@ibe.miee.ru>
Message-Id: <200212090701.gB971Teu008958@ibe.miee.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  As of dualie Xeon vs one-way, the possible reason is the SMP overhead,
because single thread can not benefit from multicpuness...

cheers, Samium Gromoff
