Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSJYVip>; Fri, 25 Oct 2002 17:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJYVio>; Fri, 25 Oct 2002 17:38:44 -0400
Received: from dsl-213-023-039-129.arcor-ip.net ([213.23.39.129]:6827 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261613AbSJYVio>;
	Fri, 25 Oct 2002 17:38:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] CONFIG_TINY
Date: Fri, 25 Oct 2002 23:45:51 +0200
X-Mailer: KMail [version 1.3.2]
References: <20021023215117.A29134@jaquet.dk>
In-Reply-To: <20021023215117.A29134@jaquet.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E185CHA-0008QJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 October 2002 21:51, Rasmus Andersen wrote:
> The purpose of this mail is to get feedback in form of further
> areas where kernel size could be reduced, to learn if others
> are looking at some of these points and to see if I get some
> of the aforementioned 'never going to make it' noises.

Well, actually the main point is to get the CONFIG_TINY symbol into 
mainline, even if it doesn't do much at first.  That in itself will
be enough to inspire various artists to contribute their own
creative minimalizing hacks to the subsystems in which they have
specific expertise.

I'll bet you beer that some of the minimized subsystems eventually
supplant their more bloated brethren, as superior in every way.

-- 
Daniel
