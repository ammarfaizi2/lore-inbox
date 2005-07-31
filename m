Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVGaQy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVGaQy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 12:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGaQy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 12:54:57 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:17849 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261815AbVGaQy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 12:54:57 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 ub 2/3: Fold one line
Date: Mon, 01 Aug 2005 02:54:43 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <kc0qe1p9jntplnu3qkr4da3uaulhimcm7i@4ax.com>
References: <20050730225145.4b99ecd0.zaitcev@redhat.com> <2538186705073106375a8b95cb@mail.gmail.com>
In-Reply-To: <2538186705073106375a8b95cb@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2005 09:37:43 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:

>On 7/31/05, Pete Zaitcev <zaitcev@redhat.com> wrote:
>> Evidently, Yani Ioannou's display is wider than mine.
>
>1600x1200@15" (Thinkpad) ;-). The changes were done by a script I
>wrote which wasn't checking if the 80 chars limit was surpassed. 

And repairing the files you stomped on?  A combination of you stomping 
coding style plus a maintainer insisting on trailing whitespace was 
enough for me to give up working in that area.  

Grant.

