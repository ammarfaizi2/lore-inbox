Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266197AbSKFXHG>; Wed, 6 Nov 2002 18:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266198AbSKFXHG>; Wed, 6 Nov 2002 18:07:06 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:55303
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266197AbSKFXHF>; Wed, 6 Nov 2002 18:07:05 -0500
Date: Wed, 6 Nov 2002 18:13:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Matt Simonsen <matt_lists@careercast.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: build kernel for server farm
In-Reply-To: <1036620009.1332.12.camel@mattsworkstation>
Message-ID: <Pine.LNX.4.44.0211061813170.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2002, Matt Simonsen wrote:

> First, I plan on compiling the kernel on a development box. From there
> my plan is basically tar /usr/src/linux, copy to each box, untar, copy
> bzImage and System.map to /boot, run make modules_install, edit
> lilo.conf, run lilo.
> 
> Tips? Comments?

Network file system?

-- 
function.linuxpower.ca


