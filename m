Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288158AbSAXOqL>; Thu, 24 Jan 2002 09:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288238AbSAXOqE>; Thu, 24 Jan 2002 09:46:04 -0500
Received: from extra.storm.com.pl ([195.116.229.162]:4619 "EHLO
	extra.storm.com.pl") by vger.kernel.org with ESMTP
	id <S288158AbSAXOps>; Thu, 24 Jan 2002 09:45:48 -0500
From: piotr@storm.com.pl
To: <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Missing changelog to Ingo's J5 scheduler?
In-Reply-To: <Pine.LNX.4.33.0201232324550.14887-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201232324550.14887-100000@localhost.localdomain>
Date: Thu, 24 Jan 2002 15:45:28 +0100
Message-Id: <20020124144538Z462942-686+9@extra.storm.com.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mlist.linux.kernel, you wrote:
> 
> J5 is the next step towards better interactiveness. Lowered the default
> timeslice length from 250 msecs to 150 msecs - long timeslices were
> clearly causing problems for certain applications.
> 
> there are some changes in my tree that will be -J6, will write a fuller
> changelog, there are cleanups from other people included as well.
 
I'm running now J5 on 2.4.17 vanilla, UP.
Everything runs smooth. No problems whatsoever.

