Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266378AbRGJORL>; Tue, 10 Jul 2001 10:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbRGJORB>; Tue, 10 Jul 2001 10:17:01 -0400
Received: from weta.f00f.org ([203.167.249.89]:40066 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266378AbRGJOQq>;
	Tue, 10 Jul 2001 10:16:46 -0400
Date: Wed, 11 Jul 2001 02:16:39 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <20010711021639.B31966@weta.f00f.org>
In-Reply-To: <200107101412.f6AEC0W06951@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107101412.f6AEC0W06951@ns.caldera.de>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 04:12:00PM +0200, Christoph Hellwig wrote:

    Why limit the user?  There are more than enough Linux system that
    have more than 32 CPUs (SGI, DEC, Sun).

The limit is architecture dependant, for ia32/i386 is it 32.

    Making it a per-architecture value or even a config option make a
    lot more sense.

It turns out I was full of it, you can buy off the shelf 32-processor
systems.

In anyone from Compaq is reading this, you should send me a 32-way
Xeon ASAP just to prove they really work :)



  --cw
