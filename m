Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWEBG5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWEBG5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWEBG5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:57:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:36548 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932415AbWEBG5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:57:31 -0400
To: Marcin Hlybin <marcin.hlybin@swmind.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Open Discussion, kernel in production environment
References: <200605012357.48623.marcin.hlybin@swmind.com>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2006 08:57:19 +0200
In-Reply-To: <200605012357.48623.marcin.hlybin@swmind.com>
Message-ID: <p731wvc7w34.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Hlybin <marcin.hlybin@swmind.com> writes:

> Hello,
> 
> I always configure and compile a kernel throwing out all unusable options and 
> I never use modules in production environment (especially for the router). 
> But my superior has got the other opinion - he claims that distribution 
> kernel is quite good and in these days optimization has no sense because of 
> powerful hadrware. 
> What do you think? I have few arguments for this discussion but I wonder what 
> you say. Please, try to substantiate your opinions.

Try to benchmark the difference. If you can't it's wasted work.
Most likely you can't.

-Andi
