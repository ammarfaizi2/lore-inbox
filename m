Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317674AbSGOWL6>; Mon, 15 Jul 2002 18:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317678AbSGOWL5>; Mon, 15 Jul 2002 18:11:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60867 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317674AbSGOWL4>; Mon, 15 Jul 2002 18:11:56 -0400
Date: Mon, 15 Jul 2002 18:12:59 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: cowboy@badlands.lexington.ibm.com
To: "Patrick J. LoPresti" <patl@curl.com>
cc: Chris Mason <mason@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <s5gy9ccr84k.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.4.44.0207151810150.2834-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jul 2002, Patrick J. LoPresti wrote:

> I really wish MTA authors would just support Linux's "fsync the
> directory" approach.  It is simple, reliable, and fast.  Yes, it does
> require Linux-specific support in the application, but that's what
> application authors should expect when there is a gap in the
> standards.

This is exactly what sendmail did in its 8.12.0 release (2001/09/08)

-- 
Rick Nelson
"...very few phenomena can pull someone out of Deep Hack Mode, with two
noted exceptions: being struck by lightning, or worse, your *computer*
being struck by lightning."
(By Matt Welsh)

