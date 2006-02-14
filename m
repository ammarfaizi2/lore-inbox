Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWBNKBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWBNKBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWBNKBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:01:10 -0500
Received: from mail.suse.de ([195.135.220.2]:55531 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750837AbWBNKBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:01:09 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16-rc3: another issue: x86_64 with ATI chipsets
Date: Tue, 14 Feb 2006 11:01:01 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200602140458_MC3-1-B85E-D2B9@compuserve.com>
In-Reply-To: <200602140458_MC3-1-B85E-D2B9@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141101.01556.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 10:54, Chuck Ebbert wrote:
> I'm just reporting this so it can be tracked.

It's already tracked in bugzilla.

> Andi has just reopened Kernel Bugzilla bug #3927 concerning time running
> too fast on ATI chipsets because of a confirmed problem on -rc3.

It's pretty unlikely it can be all fixed up for 2.6.16 anyways.  It's not
a single problem, but a wide range.

-Andi
