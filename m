Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUAKRo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUAKRo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:44:28 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:57811 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S265920AbUAKRo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:44:27 -0500
To: rml@ximian.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Laptops & CPU frequency
In-Reply-To: <1073841200.1153.0.camel@localhost>
References: <20040111025623.GA19890@ncsu.edu> <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost> <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <1073841200.1153.0.camel@localhost>
Message-Id: <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Sun, 11 Jan 2004 17:44:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>No - if the laptop changes speed on its own, using a system that Linux
>does not understand, then Linux won't know about the change,
>/proc/cpuinfo will not be updated, and stuff won't go too good.

Is there any realistic way of noticing this sort of change?
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
