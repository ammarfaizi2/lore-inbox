Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283767AbRK3UEe>; Fri, 30 Nov 2001 15:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283772AbRK3UEX>; Fri, 30 Nov 2001 15:04:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:43787 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S283767AbRK3UEP>;
	Fri, 30 Nov 2001 15:04:15 -0500
Subject: Re: [patch] smarter atime updates
From: Robert Love <rml@tech9.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0111301344330.17515-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0111301344330.17515-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 15:03:39 -0500
Message-Id: <1007150620.4238.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-30 at 10:44, Marcelo Tosatti wrote:

> Now are you sure this can't break anything ?

It certainly won't break ext2 and ext3, and it probably does offer a
nice performance benefit.

	Robert Love

