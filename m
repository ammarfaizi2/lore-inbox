Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263150AbSJBQ3x>; Wed, 2 Oct 2002 12:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbSJBQ3w>; Wed, 2 Oct 2002 12:29:52 -0400
Received: from dsl-213-023-022-021.arcor-ip.net ([213.23.22.21]:15490 "EHLO
	starship") by vger.kernel.org with ESMTP id <S263150AbSJBQ3w>;
	Wed, 2 Oct 2002 12:29:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] dump_stack() cleanup, BK-curr
Date: Wed, 2 Oct 2002 18:35:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210021112020.6201-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0210021112020.6201-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wmTG-0001Zn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 11:22, Ingo Molnar wrote:
> The attached (tested) patch modifies x86's dump_stack() to print out the
> much friendlier backtrace.

How about calling it backtrace(), since that's now what it is.

-- 
Daniel
