Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263648AbRFFREu>; Wed, 6 Jun 2001 13:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263653AbRFFREn>; Wed, 6 Jun 2001 13:04:43 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:10113 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S263648AbRFFREf>;
	Wed, 6 Jun 2001 13:04:35 -0400
Date: Wed, 6 Jun 2001 19:04:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010606190418.A2098@suse.cz>
In-Reply-To: <20010606125556.A1766@suse.cz> <Pine.LNX.4.10.10106060916130.5244-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106060916130.5244-100000@transvirtual.com>; from jsimmons@transvirtual.com on Wed, Jun 06, 2001 at 09:17:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 09:17:56AM -0700, James Simmons wrote:

> Is it possible to move serio.c and serport.c up into drivers/char. I'm
> finding many drivers that use this and it is a mess to have to enable
> joysticks just to use other types of devices like touchscreens.

Possible it indeed is.

-- 
Vojtech Pavlik
SuSE Labs
