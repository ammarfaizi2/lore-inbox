Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWIFFAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWIFFAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 01:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWIFFAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 01:00:52 -0400
Received: from 1wt.eu ([62.212.114.60]:10258 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932088AbWIFFAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 01:00:51 -0400
Date: Wed, 6 Sep 2006 07:00:44 +0200
From: Willy Tarreau <w@1wt.eu>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
Message-ID: <20060906050044.GC604@1wt.eu>
References: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net> <44FE5019.6010404@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FE5019.6010404@oracle.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 09:35:37PM -0700, Zach Brown wrote:
> 
> There was a 3/5 but the bogofilter decided it was spam.  It made it into
> the linux-aio archive:
> 
>   http://marc.theaimsgroup.com/?l=linux-aio&m=115750084710650&w=2
> 
> What should I have done to avoid the spam regexes and what should I do
> now that I have a patch that makes them angry?

I don't know. IMHO, bogofilter should only add a header so that people
who want to filter can and those who don't want to will get all the
messages. Spam has never been a real problem for me on LKML, but loss
of messages and patches will certainly be. I would rather have the choice
to not filter anything :-/

Willy

