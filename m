Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278736AbRJVLs3>; Mon, 22 Oct 2001 07:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278740AbRJVLsW>; Mon, 22 Oct 2001 07:48:22 -0400
Received: from sabre-wulf.nvg.ntnu.no ([129.241.210.67]:65039 "EHLO
	sabre-wulf.nvg.ntnu.no") by vger.kernel.org with ESMTP
	id <S278735AbRJVLsG>; Mon, 22 Oct 2001 07:48:06 -0400
Date: Mon, 22 Oct 2001 13:48:26 +0200 (CEST)
From: =?iso-8859-1?Q?Roar_Thron=E6s?= <roart@nvg.ntnu.no>
To: <linux-kernel@vger.kernel.org>
Subject: increase the number of system call parameters
Message-ID: <Pine.LNX.4.33.0110221334200.1121-100000@hagbart.nvg.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

(I am sorry if this question has been asked and answered before)

How do you increase the number of system call parameters, and how many
can you at most have?
Would up to 12 parameters be possible, and how?

I have looked at asm-i386/unistd, but it does not seem as intuitive as for
some other processors (and I am still soon going to learn x86...).
Are changes other places needed?

-- 
-Roar Thronæs


