Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbTJ1P5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 10:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTJ1P5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 10:57:10 -0500
Received: from intra.cyclades.com ([64.186.161.6]:53971 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264028AbTJ1P5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 10:57:07 -0500
Date: Tue, 28 Oct 2003 13:49:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Joachim Bremer <joachim.bremer@ricardo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre8 - ACPI Kernel Panic on boot
In-Reply-To: <200310281332.h9SDW2708105@sarah.ricardo.de>
Message-ID: <Pine.LNX.4.44.0310281349210.4639-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Oct 2003, Joachim Bremer wrote:

> Hi,
> 
> on my laptop HP NX9005 2.4.23pre8 will panic on boot. Tracing
> down the differences between 2.4.23pre7 and pre8 a found that
> the problems is in patchset 1.1063.43.26. Backing out this patch
> lets the laptop boot again. Decode oops follows.

Joachim, 

The patch in question has caused other problems and will be removed.



