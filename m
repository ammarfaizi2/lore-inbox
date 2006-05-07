Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWEGOoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWEGOoh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 10:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWEGOoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 10:44:37 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:41447
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932169AbWEGOog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 10:44:36 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [patch 3/6] New Generic HW RNG
Date: Sun, 7 May 2006 16:51:40 +0200
User-Agent: KMail/1.9.1
References: <20060507113513.418451000@pc1> <20060507113605.144341000@pc1> <20060507170916.510a66d7.vsu@altlinux.ru>
In-Reply-To: <20060507170916.510a66d7.vsu@altlinux.ru>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071651.40739.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 15:09, you wrote:
> On Sun, 07 May 2006 13:35:16 +0200 Michael Buesch wrote:
> 
> > Add a driver for the x86 RNG.
> > This driver is ported from the old hw_random.c
> 
> In fact, this is 4 completely different drivers - probably they should
> be split now?

I can split them, it it is really desired to do this in this
patch series. It can also be done later.
What should I do?

-- 
Greetings Michael.
