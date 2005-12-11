Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVLKNwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVLKNwF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 08:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVLKNwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 08:52:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:39061 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750700AbVLKNwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 08:52:03 -0500
Date: Sun, 11 Dec 2005 14:51:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, David Singleton <dsingleton@mvista.com>
Subject: Re: [PATCH] Fix timeout in robust path
Message-ID: <20051211135116.GD30475@elte.hu>
References: <20051207193429.GD4897@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207193429.GD4897@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dinakar Guniguntala <dino@in.ibm.com> wrote:

> Hi Ingo,
> 
> I hit the following BUG when exercising the robust futex path

thanks - i picked your fix up via David's patch-2.6.14-rt22-rf11.

	Ingo
