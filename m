Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287276AbSA1LwA>; Mon, 28 Jan 2002 06:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287149AbSA1Lvu>; Mon, 28 Jan 2002 06:51:50 -0500
Received: from dsl-213-023-043-003.arcor-ip.net ([213.23.43.3]:8065 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287276AbSA1Lvn>;
	Mon, 28 Jan 2002 06:51:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Don't use dbench for benchmarks
Date: Mon, 28 Jan 2002 12:56:42 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020127043539.56216.qmail@web9203.mail.yahoo.com>
In-Reply-To: <20020127043539.56216.qmail@web9203.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VAOw-00009Y-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 27, 2002 05:35 am, Alex Davis wrote:
> I ran dbench on three different kernels: 2.4.17 w/ rmap12a, 2.4.18pre7, and
> 2.4.18pre7 w/ rmap12a. 2.4.18pre7 had better throughput by a substantial 
> margin. The results are at http://www.dynamicbullet.com/rmap.html

I must be having a bad day, I can only think of irritable things to post.
Continuing that theme: please don't use dbench for benchmarks.  At all.
It's an unreliable indicator of anything in particular except perhaps
stability.  Please, use something else for your benchmarks.

-- 
Daniel
