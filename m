Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263923AbRFRLV1>; Mon, 18 Jun 2001 07:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263929AbRFRLVH>; Mon, 18 Jun 2001 07:21:07 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:13831 "EHLO
	norma.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S263923AbRFRLVD>; Mon, 18 Jun 2001 07:21:03 -0400
Date: Mon, 18 Jun 2001 20:21:39 +0900
Message-Id: <200106181121.f5IBLdc02300@norma.kjist.ac.kr>
From: root <root@norma.kjist.ac.kr>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 VM & swap question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Regarding to the discussion on the swap size,

Recently, Rick van Riel posted a message that there is a bug 
related to "reclaiming" the swap, and said that it is on his 
TODO list.

If I believe it, the current trouble we have regarding to the swap 
size is not because we do not have a sufficient size for the swap, 
but because there is a bug, although Linus advised us to assign
2 times the physical memory for the swap.

I don't know.

Anyway, I am trying to put an extra 4GB hard disk on an Alpha UP2000 right now.

Regards,

Hugh
