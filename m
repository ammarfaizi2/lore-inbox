Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbTDTORh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 10:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTDTORh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 10:17:37 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7296 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263585AbTDTORg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 10:17:36 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304201432.h3KEWboQ000337@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH 2.5] report unknown NMI reasons only once
To: der.eremit@email.de (Pascal Schmidt)
Date: Sun, 20 Apr 2003 15:32:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, zwane@linuxpower.ca (Zwane Mwaikambo)
In-Reply-To: <E197FVf-0000GS-00@neptune.local> from "Pascal Schmidt" at Apr 20, 2003 04:09:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Beats me as to what could be wrong. It's not a memory problem and the
> >> CPU does not overheat.
> >> 
> >> I'll go patch the kernel for my personal use then, but I'm not the only
> >> one seeing those messages without any system problems.
> > 
> > It's all fun and games until NMIs turn into MCEs...
> 
> I have the MCE polling stuff enabled and will keep an eye on it. So far
> I suspect flaky motherboard design (Athlon XPs didn't even exist when
> this piece of hardware was designed).
> 
> It's definitely CPU-related since it never happened with the Duron
> processor that I used before.

Are you sure that the CPU voltage is correct?

John.
