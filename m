Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSGJTPu>; Wed, 10 Jul 2002 15:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSGJTPt>; Wed, 10 Jul 2002 15:15:49 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:30407 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S315628AbSGJTPs>; Wed, 10 Jul 2002 15:15:48 -0400
Date: Wed, 10 Jul 2002 22:18:24 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  July 10, 2002
Message-ID: <20020710191824.GT1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <3D2B89AC.25661.91896FEB@localhost> <1026323661.1178.73.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026323661.1178.73.camel@sinai>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 10:54:21AM -0700, you [Robert Love] wrote:
> 
> As of 2.5.25, we have HZ=1000 (on x86) and a scalable user-space
> exported clock_t that remains at 100 HZ to keep user-space compatible. 
> This is attributed to the Commander in Chief, Linus Torvalds.

But jiffies now wrap at 49.7 days, right? If so, did Tim Schmielau's jiffies
wrap patches go in as well? ISTR they went in -dj.

Didn't Red Hat change HZ to 1000 (or 1024) in Limbo as well? How did they
handle that?


-- v --

v@iki.fi
