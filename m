Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTH1RbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 13:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbTH1RbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 13:31:13 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:43465 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S264097AbTH1RbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 13:31:12 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308281726.SAA24033@mauve.demon.co.uk>
Subject: Re: Lockless file reading
To: jamie@shareable.org (Jamie Lokier)
Date: Thu, 28 Aug 2003 18:26:49 +0100 (BST)
Cc: ragnar@linalco.com (Ragnar Hojland Espinosa),
       davids@webmaster.com (David Schwartz), tss@iki.fi (Timo Sirainen),
       linux-kernel@vger.kernel.org
In-Reply-To: <20030828130326.GF6800@mail.jlokier.co.uk> from "Jamie Lokier" at Aug 28, 2003 02:03:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Ragnar Hojland Espinosa wrote:
> > It can happen.  It happened to me with two gifs.  FWIW.
> 
> Probability on the order of 2^-32 with MD5 any-pairs collision.
> (It's not usual to have so many GIFs to compare, though :)
> SHA is better, and both probably have some weakness that increases the
> probability of collision.
> 
> Do you still have the GIFs?

MD5 is 128 bit output, so that's around 2^64 pairs before you have a birthday.
There arn't that many GIFs in the world.
I'd be really surprised if there were that many pictures in the world.
