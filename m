Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTDOTio (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbTDOTio 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:38:44 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:58886 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264043AbTDOTil (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 15:38:41 -0400
Date: Tue, 15 Apr 2003 20:50:31 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67-mm3: CONFIG_VIDEO_SELECT
In-Reply-To: <1050355641.9160.34.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.44.0304152050010.8236-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I can't compile 2.5.67-mm3 successfully if CONFIG_VIDEO_SELECT is not
> set in ".config". The compilation fails at setup.o, complaining that
> "store_edid" (defined in video.S) cannot be resolved.
> 
> I had to set CONFIG_VIDEO_SELECT in order to compile.

The VIDEO_SELECT needs some cleanup. I'm going to be working on it the 
next few days.


