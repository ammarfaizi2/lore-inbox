Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267777AbTBRMZs>; Tue, 18 Feb 2003 07:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbTBRMZs>; Tue, 18 Feb 2003 07:25:48 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:29191 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267777AbTBRMZr>; Tue, 18 Feb 2003 07:25:47 -0500
Date: Tue, 18 Feb 2003 13:35:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030218042042.R2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302181332020.1336-100000@serv>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org>
 <20030218042042.R2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Feb 2003, Werner Almesberger wrote:

> I don't think we'll make much progress if we keep on mixing issues
> of interface correctness, current module constraints, and possible
> module interface changes, all that with performance considerations
> and minimum invasive migration plans thrown in. So I'd suggest the
> following sequence:

Um, another point, let's ignore "minimum invasive migration plans", if we 
found a good solution, we can still figure out how to get there smoothly, 
so this shouldn't be a primary concern.

bye, Roman

