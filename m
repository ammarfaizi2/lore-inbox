Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbSJQU0M>; Thu, 17 Oct 2002 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbSJQUZx>; Thu, 17 Oct 2002 16:25:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35518 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262003AbSJQUZn>;
	Thu, 17 Oct 2002 16:25:43 -0400
Date: Thu, 17 Oct 2002 13:24:11 -0700 (PDT)
Message-Id: <20021017.132411.102443707.davem@redhat.com>
To: bgerst@didntduck.org
Cc: eric@bartonsoftware.com, linux-kernel@vger.kernel.org
Subject: Re: kernel vaddr -> struct page
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DAF0E81.4000101@didntduck.org>
References: <200210171911.g9HJBHk02456@bartonsoftware.com>
	<3DAF0E81.4000101@didntduck.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brian Gerst <bgerst@didntduck.org>
   Date: Thu, 17 Oct 2002 15:24:49 -0400

   virt_to_page()
   
Doesn't work on vmalloc() data, he said that was a possibility for his
case.
