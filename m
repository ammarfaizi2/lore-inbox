Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbTBEMxJ>; Wed, 5 Feb 2003 07:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTBEMxI>; Wed, 5 Feb 2003 07:53:08 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:39563 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S267285AbTBEMxI>;
	Wed, 5 Feb 2003 07:53:08 -0500
From: b_adlakha@softhome.net
To: linux-kernel@vger.kernel.org
Subject: HYPERTHREADING on older P4???
Date: Wed, 05 Feb 2003 06:02:43 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [210.214.82.3]
Message-ID: <courier.3E410B73.000041C3@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
/proc/cpuinfo reports "ht" in the supported options...I have a p4 2 ghz 
stepping 4, and when I boot with an SMP kernel, it shows another thing :
siblings 1 

I think HT is there in all p4s, so can it be enabled in older P4s? Like 
mine? What does "siblings = 1" mean? 
