Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbTI3XJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTI3XJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:09:37 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:5070 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S261800AbTI3XJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:09:35 -0400
Date: Tue, 30 Sep 2003 16:09:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: cliff white <cliffw@osdl.org>
Cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 - stuck keys on iBook
Message-ID: <20030930230931.GB12343@ip68-0-152-218.tc.ph.cox.net>
References: <20030930143149.4930ec9c.cliffw@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930143149.4930ec9c.cliffw@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 02:31:49PM -0700, cliff white wrote:

> 
> Kernel version: latest from ppc.bkbits.net/linuxppc-2.5
> 
> Symptom: keyboard diarrhea - single keypress == 3-7 characters.
> 
> I've tried reverting drivers/input/keyboards/atkbd.c back to v1.31, doesn't
> change anything.

Just FYI, atkbd isn't used on pmacs.

-- 
Tom Rini
http://gate.crashing.org/~trini/
