Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRDQFIM>; Tue, 17 Apr 2001 01:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbRDQFHw>; Tue, 17 Apr 2001 01:07:52 -0400
Received: from geos.coastside.net ([207.213.212.4]:64226 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S130471AbRDQFHt>; Tue, 17 Apr 2001 01:07:49 -0400
Mime-Version: 1.0
Message-Id: <p05100b07b7017fc83c2e@[207.213.214.34]>
In-Reply-To: <3ADBB8C9.CC7FD941@nc.rr.com>
In-Reply-To: <3ADBB8C9.CC7FD941@nc.rr.com>
Date: Mon, 16 Apr 2001 22:07:56 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Documentation of module parameters.
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:30 PM -0400 2001-04-16, Chris Kloiber wrote:
>I was recently looking for a single location where all the possible
>module parameters for the linux kernel was located.

Hear him. A DocBook document would be a dandy place for this to get pulled together, too.

>I figured I would look at the source first, hoping that each module
>maintaier would clearly document at the beginning of each .c file all of
>the parameters his or her module can accept. Sadly, that's not always
>the case. Some modules are well documented, others are a complete
>mystery. If I was a programmer myself, I might be able to determine from
>the code itself what parameters are possible, but that's not one of my
>talents. Could any and all of you please take the time to document your
>code, and keep the comments up to date when it changes? I think that in
>the source code itself is the best place for such documentation, as you
>have the chance to fix the docs with every patch, and the source is
>always included in each distribution. Then from the source can any
>exterior documentation be gleaned. Those of us who don't speak C would
>really appreciate it.
>
>Thanks In Advance.
>
>Chris Kloiber


-- 
/Jonathan Lundell.
