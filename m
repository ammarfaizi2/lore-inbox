Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292992AbSCDXaD>; Mon, 4 Mar 2002 18:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293007AbSCDX3x>; Mon, 4 Mar 2002 18:29:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54415 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292992AbSCDX3l>;
	Mon, 4 Mar 2002 18:29:41 -0500
Date: Mon, 04 Mar 2002 15:26:46 -0800 (PST)
Message-Id: <20020304.152646.123971801.davem@redhat.com>
To: raghuangadi@yahoo.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: memory corruption in tcp bind hash buckets on SMP?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020304204832.79585.qmail@web12305.mail.yahoo.com>
In-Reply-To: <200203011907.WAA08216@ms2.inr.ac.ru>
	<20020304204832.79585.qmail@web12305.mail.yahoo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Raghu Angadi <raghuangadi@yahoo.com>
   Date: Mon, 4 Mar 2002 12:48:32 -0800 (PST)

   We have been load testing the kernel with this patch (reverse the insertion
   order in __tcp_tw_hashdance(). It seems to work fine till now.

Where was "this patch" posted?  I never saw anyone post
any code, all anyone did was merely describe the change :)
