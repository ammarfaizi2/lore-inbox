Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318999AbSHMQy5>; Tue, 13 Aug 2002 12:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319000AbSHMQy5>; Tue, 13 Aug 2002 12:54:57 -0400
Received: from ivimey.org ([194.106.52.201]:52785 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S318999AbSHMQy4>;
	Tue, 13 Aug 2002 12:54:56 -0400
Date: Tue, 13 Aug 2002 17:56:34 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Christoph Hellwig <hch@infradead.org>
cc: Erik Andersen <andersen@codepoet.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <20020813171138.A12546@infradead.org>
Message-ID: <Pine.LNX.4.44.0208131756000.19585-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Christoph Hellwig wrote:

>On Tue, Aug 13, 2002 at 10:09:24AM -0600, Erik Andersen wrote:
>
>And as I said again, it doesn't really clone - it starts something
>different, namely the fn argument.

How about:

  sys_launch
or
  sys_run_process


Ruth


-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

