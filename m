Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263531AbRFFQSS>; Wed, 6 Jun 2001 12:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263534AbRFFQSI>; Wed, 6 Jun 2001 12:18:08 -0400
Received: from www.transvirtual.com ([206.14.214.140]:18698 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S263531AbRFFQSA>; Wed, 6 Jun 2001 12:18:00 -0400
Date: Wed, 6 Jun 2001 09:17:56 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [driver] New life for Serial mice
In-Reply-To: <20010606125556.A1766@suse.cz>
Message-ID: <Pine.LNX.4.10.10106060916130.5244-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it possible to move serio.c and serport.c up into drivers/char. I'm
finding many drivers that use this and it is a mess to have to enable
joysticks just to use other types of devices like touchscreens.

