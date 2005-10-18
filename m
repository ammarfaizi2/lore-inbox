Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVJRLMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJRLMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 07:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVJRLMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 07:12:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:3806 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750700AbVJRLMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 07:12:53 -0400
Date: Tue, 18 Oct 2005 13:12:42 +0200
From: Olaf Hering <olh@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@elte.hu, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable PREEMPT_BKL per default
Message-ID: <20051018111242.GC17971@suse.de>
References: <20051016154108.25735ee3.akpm@osdl.org> <20051018074511.GA13182@suse.de> <1129622010.2779.6.camel@laptopd505.fenrus.org> <20051018084706.GA14666@suse.de> <1129625881.2779.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1129625881.2779.12.camel@laptopd505.fenrus.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Oct 18, Arjan van de Ven wrote:

> > Its disabled in our configs.
> 
> any particular reason for that? Eg are there any known or suspected
> issues with this?

I have no idea. Maybe it was the general 'preempt isnt right' move.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
