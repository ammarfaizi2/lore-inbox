Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUIOKUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUIOKUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUIOKUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:20:11 -0400
Received: from sd291.sivit.org ([194.146.225.122]:58061 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S264500AbUIOKUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:20:06 -0400
Date: Wed, 15 Sep 2004 12:20:03 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040915102003.GA21917@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040913135253.GA3118@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913135253.GA3118@crusoe.alcove-fr>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 03:52:53PM +0200, Stelian Pop wrote:

> Hi all,
> 
> Is there a reason there is no API implementing a simple in-kernel
> FIFO ? A linked list is a bit overkill...
> 
> Besides my sonypi and meye drivers which could use this, there are
> quite a few other drivers which re-implement the circular buffer
> over and over again...
> 
> An initial implementation follows below. Comments ?

Two days later, I've got no comments at all.

Is this because the idea or the implementation are just stupid ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
