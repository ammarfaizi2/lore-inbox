Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUANUlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUANUlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:41:19 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:14783 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S263424AbUANUlQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:41:16 -0500
Date: Wed, 14 Jan 2004 15:41:15 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
In-Reply-To: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
Message-ID: <Pine.GSO.4.58.0401141538510.10553@denali.ccs.neu.edu>
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about that, this is the link I meant:
http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/0025.html

On Wed, 14 Jan 2004, Jim Faulkner wrote:

> Based on this:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/002B.html
> I'm guessing that the corruption I am experiencing is because I have a
> highmem machine.  Its a Dell Precision Workstation 530MT (dual 1.8ghz p4
