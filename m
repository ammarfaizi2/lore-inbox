Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbULaO6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbULaO6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 09:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbULaO6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 09:58:33 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:35206 "HELO
	mother.localdomain") by vger.kernel.org with SMTP id S262099AbULaO6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 09:58:31 -0500
Date: Sun, 10 Oct 2004 18:41:49 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why no linux-2.6.8.2? (was Re: new dev model)
Message-ID: <20041010164149.GA8508@irc.pl>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <200410070134_MC3-1-8BA9-A215@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410070134_MC3-1-8BA9-A215@compuserve.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 01:31:39AM -0400, Chuck Ebbert wrote:
> Why has linux 2.6.8 been abandoned at version 2.6.8.1?
> 
> There exist fixes that could go into 2.6.8.2:
> 
>         process start time doesn't match system time
>         FDDI frame doesn't allow 802.3 hwtype
>         NFS server using XFS filesystem on SMP machine oopses

 - Qdisc alignment errors, effectivly killing almost every single Linux router.
 - giant memory leaks when writing audio cds (IIRC)

-- 
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox

