Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRJBPcx>; Tue, 2 Oct 2001 11:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275337AbRJBPcn>; Tue, 2 Oct 2001 11:32:43 -0400
Received: from hermes.toad.net ([162.33.130.251]:21713 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S275178AbRJBPcX>;
	Tue, 2 Oct 2001 11:32:23 -0400
Subject: Re: Untitled
To: linux-kernel@vger.kernel.org
Date: Tue, 2 Oct 2001 11:32:22 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011002153222.5ED6710E6@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> I have written a linux kernel module. The linux version is 2.2.14. 
> In this module I have declared an array of size 2048. If I use this array, the execution of this module function
> causes kernel to reboot. If I kmalloc() this array then execution of this module function doesnot cause any
> problem.
> Can you explain this behaviour?
> Thnaks,
> Dinesh

Hmm.  Perhaps there's is a bug in your module.

-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
