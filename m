Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWJVNXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWJVNXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 09:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWJVNXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 09:23:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41672 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750868AbWJVNXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 09:23:41 -0400
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
Date: Sun, 22 Oct 2006 15:23:29 +0200
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, art@usfltd.com
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061022122355.GC3502@stusta.de>
In-Reply-To: <20061022122355.GC3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610221523.29650.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 14:23, Adrian Bunk wrote:

> Subject    : SMP x86_64 boot problem
> References : http://lkml.org/lkml/2006/9/28/330
>              http://lkml.org/lkml/2006/10/5/289
> Submitter  : art@usfltd.com
> Status     : submitter was asked to git bisect
>              result of bisecting seems to be wrong

Does this still happen with 2.6.19rc2-latestGIT ?

-Andi
