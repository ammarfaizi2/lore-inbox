Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSH0ABv>; Mon, 26 Aug 2002 20:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318151AbSH0ABv>; Mon, 26 Aug 2002 20:01:51 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:12759 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315870AbSH0ABu> convert rfc822-to-8bit; Mon, 26 Aug 2002 20:01:50 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Michael Bellion <bellion@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Finding out whether memory was allocated with kmalloc or vmalloc
Date: Tue, 27 Aug 2002 04:06:16 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208270406.16597.bellion@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

given a pointer p, is there an easy and platform independent way to find out, 
whether the memory location that p points to was allocated with kmalloc or 
vmalloc?

Thanks
	Michael Bellion


