Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319022AbSIDCwj>; Tue, 3 Sep 2002 22:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319023AbSIDCwj>; Tue, 3 Sep 2002 22:52:39 -0400
Received: from tomts24.bellnexxia.net ([209.226.175.187]:21658 "EHLO
	tomts24-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S319022AbSIDCwj>; Tue, 3 Sep 2002 22:52:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.5.33-mm1
Date: Tue, 3 Sep 2002 22:55:43 -0400
User-Agent: KMail/1.4.3
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D7437AC.74EAE22B@zip.com.au> <3D755E2D.7A6D55C6@zip.com.au> <20020904011503.GT888@holomorphy.com>
In-Reply-To: <20020904011503.GT888@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209032255.43198.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 3, 2002 09:15 pm, William Lee Irwin III wrote:
> William Lee Irwin III <wli@holomorphy.com>

What are the numbers telling you?  Is you test faster or slower
with slablru?  Does it page more or less?  Is looking at the number
of objects the way to determine if slablru is helping?  I submit
the paging and runtimes are much better indications?  What do
story do they tell?

Thanks
Ed

