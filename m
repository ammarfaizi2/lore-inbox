Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbTEaWu3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 18:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTEaWu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 18:50:29 -0400
Received: from [207.48.83.9] ([207.48.83.9]:55560 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S264482AbTEaWu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 18:50:28 -0400
Date: Sat, 31 May 2003 19:00:32 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Alexandre Pereira Nunes <alex@PolesApart.wox.org>,
       <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.21-rc6 ide-scsi bug?
In-Reply-To: <20030531215638.GC25810@matchmail.com>
Message-ID: <Pine.LNX.4.44.0305311858370.5395-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Mike Fedyk wrote:

> On Sat, May 31, 2003 at 03:57:11PM -0400, Byron Stanoszek wrote:
> > I'm currently using 2.4.20-pre5-ac1 with Andre Hedrick's IDE Patch applied. So,
> 
> Do you need this patch?  Why isn't Alan's code enough?

Um, no, I just never upgraded my kernel since 2.4.20-pre5-ac1. At that time,
ide-scsi didn't work in the -ac series, and Andre Hedrick had initially
released his patches for it to work.

I recommend sticking with the latest -ac version regardless. :) It has most of
Andre's patches in anyway, with everything else fixed--except for this one
problem.

 -Byron

> 
> If Andre isn't sending his patches or Alan hasn't integrated them then maybe
> Alan has some plans for it.
> 
> Also, maybe the patch is incompatible with the latest -ac?
> 

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

