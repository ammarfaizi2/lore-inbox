Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVGTMQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVGTMQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 08:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVGTMQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 08:16:43 -0400
Received: from adminl.w2k.inl.nl ([132.229.188.116]:22793 "EHLO
	adminl.w2k.inl.nl") by vger.kernel.org with ESMTP id S261187AbVGTMQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 08:16:43 -0400
From: Bastiaan Naber <naber@inl.nl>
To: linux-kernel@vger.kernel.org
Subject: a 15 GB file on tmpfs
Date: Wed, 20 Jul 2005 14:16:36 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201416.36155.naber@inl.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not sure if I can ask this here but I could not find any other place 
where I could fine anyone with this knowledge.

I have a 15 GB file which I want to place in memory via tmpfs. I want to do 
this because I need to have this data accessible with a very low seek time.

I want to know if this is possible before spending 10,000 euros on a machine 
that has 16 GB of memory. 

The machine we plan to buy is a HP Proliant Xeon machine and I want to run a 
32 bit linux kernel on it (the xeon we want doesn't have the 64-bit stuff 
yet)

Thanks in advance,
Bastiaan

