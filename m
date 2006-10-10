Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030546AbWJJVww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbWJJVww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbWJJVwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:52:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030559AbWJJVwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:52:44 -0400
Date: Tue, 10 Oct 2006 14:52:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.19-rc1-mm1
Message-Id: <20061010145235.b86c7bad.akpm@osdl.org>
In-Reply-To: <6bffcb0e0610101444y5cf127c5y8a9e4c64640e0b8c@mail.gmail.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<6bffcb0e0610100909t3a33d4ecwdae27a27b15d60e3@mail.gmail.com>
	<20061010120441.3cd3f8ff.akpm@osdl.org>
	<6bffcb0e0610101444y5cf127c5y8a9e4c64640e0b8c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 23:44:04 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> BTW. Kernel hangs while running Cyclictest
> (http://rt.wiki.kernel.org/index.php/Cyclictest)
> cyclictest -t 10 -l 100000
> (or "bin/autotest tests/cyclictest/control" in autotest). I don't see
> nothing special on tty (currently my sysklogd is broken, FC6
> problem..)

cc added.
