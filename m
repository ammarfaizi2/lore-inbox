Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTE0KZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTE0KZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:25:46 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:10502 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263201AbTE0KZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:25:41 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm1
Date: Tue, 27 May 2003 12:38:25 +0200
User-Agent: KMail/1.5.2
References: <20030527004255.5e32297b.akpm@digeo.com>
In-Reply-To: <20030527004255.5e32297b.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271238.25935.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 09:42, Andrew Morton wrote:

Hi Andrew,

> . A number of fixes against the ext3 work which Alex and I have been doing.
>   This code is stable now.  I'm using it on my main SMP desktop machine.
>   These are major changes to a major filesystem.  I would ask that
>   interested parties now subject these patches to stresstesting and to
>   performance testing.  The performance gains on SMP will be significant.
works well for me.

ciao, Marc

