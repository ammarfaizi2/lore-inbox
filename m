Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266157AbSKVGrn>; Fri, 22 Nov 2002 01:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbSKVGrm>; Fri, 22 Nov 2002 01:47:42 -0500
Received: from angband.namesys.com ([212.16.7.85]:28852 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S266157AbSKVGrm>; Fri, 22 Nov 2002 01:47:42 -0500
Date: Fri, 22 Nov 2002 09:54:50 +0300
From: Oleg Drokin <green@namesys.com>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: paging oops with 2.4.20-rc2
Message-ID: <20021122095450.A8056@namesys.com>
References: <3DDD8339.2040409@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3DDD8339.2040409@tupshin.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Nov 21, 2002 at 05:07:05PM -0800, Tupshin Harper wrote:
> I'm experiencing frequent oops when doing much of anything 
> cpu/memory/disk intensive. I've yet to get through a kernel compilation 
> on this machine.

Is the oops always the same and looks like the one you've posted here?
Or is it different from time to time?
If it always the same, can you please try to compile your kernel with
CONFIG_REISERFS_CHECK (reiserfs debug) option enabled and see what happens?

Thank you.

Bye,
    Oleg
