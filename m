Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbUKQUxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbUKQUxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKQUuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:50:50 -0500
Received: from holomorphy.com ([207.189.100.168]:55755 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262531AbUKQUuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:50:39 -0500
Date: Wed, 17 Nov 2004 12:50:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pid_max madness
Message-ID: <20041117205024.GT3217@holomorphy.com>
References: <419BB097.8030405@kde.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419BB097.8030405@kde.org.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 09:12:07PM +0100, Grzegorz Piotr Jaskiewicz wrote:
> Let's do:
> #echo "-1" >/proc/sys/kernel/pid_max
> #cat /proc/sys/kernel/pid_max
> -1
> #
> Madness, isn't ?
> I guess that isn't what author ment it to behave like.
> Anyway, does it mean that after max unsigned value is reached pids are 
> going to be negative in value ??

Kernel version please?


-- wli
