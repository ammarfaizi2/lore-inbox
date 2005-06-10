Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVFJQxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVFJQxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVFJQxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:53:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:8325 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262568AbVFJQxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:53:16 -0400
Date: Fri, 10 Jun 2005 18:53:15 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Duffy <tduffy@sun.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] [OOPS] powernow on smp dual core amd64
Message-ID: <20050610165315.GI13234@wotan.suse.de>
References: <1118360779.13654.4.camel@duffman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118360779.13654.4.camel@duffman>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 04:46:19PM -0700, Tom Duffy wrote:
> Got this panic when I recently upgraded my BIOS so that it supports k8
> powernow on SMP dual-core.

2.6.12-rc has a dual core aware powernow k8 driver.

-Andi
