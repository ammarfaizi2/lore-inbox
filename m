Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263175AbRFCSAt>; Sun, 3 Jun 2001 14:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263702AbRFCSAk>; Sun, 3 Jun 2001 14:00:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:9408 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263175AbRFCRi1>;
	Sun, 3 Jun 2001 13:38:27 -0400
Date: Sun, 3 Jun 2001 19:37:53 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106031737.TAA118373.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: symlink_prefix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We can kludge around anything. The question being, what for?
> It still leaves ncp with its ioctls ugliness.

I show how to simplify the kernel source without changing the
interface. That is good, and there are some free benefits.

You want to design a new interface. Maybe that is good as well,
but since it is the interface of essentially a unique program
I do not regard that as very urgent.

Andries
