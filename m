Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315474AbSEBXzc>; Thu, 2 May 2002 19:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315475AbSEBXzb>; Thu, 2 May 2002 19:55:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60946 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315474AbSEBXzb>; Thu, 2 May 2002 19:55:31 -0400
Subject: Re: O(1) scheduler gives big boost to tbench 192
To: gh@us.ibm.com
Date: Fri, 3 May 2002 01:14:19 +0100 (BST)
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
In-Reply-To: <E173QdG-0000bs-00@w-gerrit2> from "Gerrit Huizenga" at May 02, 2002 05:09:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173QiK-0005Bd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you are bored, you might compare this to the MQ scheduler
> at http://prdownloads.sourceforge.net/lse/2.4.14.mq-sched
> 
> Also, I think rml did a backport of the 2.5.X version of O(1);
> I'm not sure if htat is in -ac or -jam as yet.

-ac has Robert Love's backport of the additional fixes

> Rumor is that on some workloads MQ it outperforms O(1), but it
> may be that the latest (post K3?) O(1) is catching up?

I'd be interested to know what workloads ?
