Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314810AbSD2Gdz>; Mon, 29 Apr 2002 02:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSD2Gdy>; Mon, 29 Apr 2002 02:33:54 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:60613 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S314810AbSD2Gdy>; Mon, 29 Apr 2002 02:33:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: How to enable printk
Date: Mon, 29 Apr 2002 09:33:34 +0300
X-Mailer: KMail [version 1.4]
In-Reply-To: <20020427.194302.02285733.davem@redhat.com> <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204290933.34402.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 April 2002 08:20 am, Wanghong Yuan wrote:
> Hi,
>
> It may be a simple question. But I cannot see the result of printk in
> console like the following. Do i need to enable it somewhere? Thanks
>
	man dmesg

The manual is not explicit about valid values for the logging level.
Try "dmesg -n8".

-- Itai

