Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUESUh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUESUh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUESUh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:37:56 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:41097 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S264542AbUESUhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:37:52 -0400
Message-ID: <40ABC5AF.6070109@am.sony.com>
Date: Wed, 19 May 2004 13:38:07 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <40A92D15.2060006@am.sony.com> <20040519152706.GD22742@fs.tum.de> <40AB925C.50001@am.sony.com> <20040519201639.GF24287@fs.tum.de>
In-Reply-To: <20040519201639.GF24287@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The main problem seems to be that you write much paper instead of 
> simply writing and testing code.

The specification you refer to consists of 4 sentences.  One
of them was normative.  The main goal is to communicate to
linux vendors and silicon vendors that CE companies are
interested in correct support of this option.  For the
platforms and code where this is not the default now, there
is a risk that -Os bugs might cause problems.

> Your approach might be a good solution for big projects, but if the 
> changes are relatively simple it's not very useful.

Verifying that something is supported correctly on multiple
architectures is not simple.  Yes, we know that the default
optimization level for ARM is -Os.  As recently as last month,
there was a problem report about -Os on the gcc mailing list.

I fail to see what it is about our communication (that we'd like
to see all platforms support -Os) that you find so offensive.

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

