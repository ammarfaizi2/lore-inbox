Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270833AbTHFRW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270835AbTHFRW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:22:58 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:31236
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270833AbTHFRWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:22:55 -0400
Date: Wed, 6 Aug 2003 10:22:54 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: apashaya@ucsc.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 bug
Message-ID: <20030806172254.GA21290@matchmail.com>
Mail-Followup-To: apashaya@ucsc.edu, linux-kernel@vger.kernel.org
References: <3F3052F6.8020704@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3052F6.8020704@pacbell.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 12:59:34AM +0000, Harut Pashayan wrote:
> You guys should check the framebuffer code for the Radeon, I have a 
> All-in-wonder pro 8mb pci and a radeon 7500, the radeon framebuffer 
> device doens't work, and its properly compiles, however the 
> all-in-wonder works fine.

Need: kernel version, lspci output, what exactly does happen when you try
the radeon fb...
