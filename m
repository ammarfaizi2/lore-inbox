Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUFXKFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUFXKFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUFXKFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:05:49 -0400
Received: from corpmail.outblaze.com ([203.86.166.82]:28612 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S264176AbUFXKFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:05:48 -0400
Date: Thu, 24 Jun 2004 18:05:43 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
Message-ID: <20040624100543.GB8422@outblaze.com>
References: <20040624091548.GA8264@outblaze.com> <40DA9E89.9020801@yahoo.com.au> <20040624093440.GA8422@outblaze.com> <40DAA2D2.9010008@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DAA2D2.9010008@yahoo.com.au>
User-Agent: Mutt/1.4.2i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.2-5; VAE: 6.25.0.62; VDF: 6.25.0.109; host: corpmail.outblaze.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK. They're both using 100% CPU... is 2.6.5 getting more work done?

So far, it looks like both are doing similar amount of work. am getting
more measurements from other boxes

My concern was the high system usage, I had suspected that it might have
been due interrupts generated on the NIC. This was not evident in the
profile I generated

Regards, Yusuf
