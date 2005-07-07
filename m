Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVGGMqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVGGMqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVGGMoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:44:23 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:1958
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261297AbVGGMnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:43:22 -0400
Subject: Re: Thread_Id
From: Benedikt Spranger <b.spranger@linutronix.de>
To: rvk@prodmail.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42CA79DE.9060701@prodmail.net>
References: <20050723150209.GA15055@krispykreme>
	 <42CA79DE.9060701@prodmail.net>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 14:43:21 +0200
Message-Id: <1120740201.4988.53.camel@atlas.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> Can anyone suggest me how to get the threadId using 2.6.x kernels. 
> pthread_self() does not work and returns some -ve integer.

Let me guess: You are looking for get_tid() :-)

Bene

