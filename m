Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTKQVPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTKQVPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:15:42 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:27318 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261959AbTKQVON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:14:13 -0500
Date: Mon, 17 Nov 2003 21:14:03 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
Message-ID: <20031117211403.GB20118@mail.shareable.org>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz> <20031117064832.GA16597@mail.shareable.org> <Pine.GSO.4.58.0311171236420.29330@Juliusz> <3FB91C54.5020905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB91C54.5020905@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Yes, this would be possible if FUTEX_FD wouldn't be useless as it is
> implemented today (see the futex paper I announced here recently). 

Which futex paper?

-- Jamie
