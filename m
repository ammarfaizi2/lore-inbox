Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293338AbSCJWHI>; Sun, 10 Mar 2002 17:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293339AbSCJWG7>; Sun, 10 Mar 2002 17:06:59 -0500
Received: from tapu.f00f.org ([66.60.186.129]:50820 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S293338AbSCJWGv>;
	Sun, 10 Mar 2002 17:06:51 -0500
Date: Sun, 10 Mar 2002 14:05:57 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
Message-ID: <20020310220557.GA12383@tapu.f00f.org>
In-Reply-To: <1015784104.1261.8.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1015784104.1261.8.camel@phantasy>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 01:15:03PM -0500, Robert Love wrote:

    I have updated the patch a bit and resycned to 2.5.6.  Are you
    interested?  I believe a user interface for setting task CPU
    affinity is useful and completes the rest of our sched_* syscalls.
    A syscall implementation seems to be what everyone wants (I have a
    proc-interface, too...)

Can't wer just copy the IRIX interface here as some other pathces have
in the past?



  --cw
