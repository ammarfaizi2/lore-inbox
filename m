Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311250AbSCLPl3>; Tue, 12 Mar 2002 10:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311248AbSCLPlS>; Tue, 12 Mar 2002 10:41:18 -0500
Received: from zero.tech9.net ([209.61.188.187]:43781 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311243AbSCLPlA>;
	Tue, 12 Mar 2002 10:41:00 -0500
Subject: Re: Upgrading Headers?
From: Robert Love <rml@tech9.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Brian S Queen <bqueen@nas.nasa.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <6468.1015927347@redhat.com>
In-Reply-To: <1015895241.928.107.camel@phantasy> 
	<200203120100.RAA00468@marcy.nas.nasa.gov>   <6468.1015927347@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 12 Mar 2002 10:41:17 -0500
Message-Id: <1015947678.4804.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-03-12 at 05:02, David Woodhouse wrote:

> No it may not be a symlink. That would be broken.

Well, I've seen it as a symlink, but then you are not supposed to
recompile out of /usr/src/linux ... that was why, I assumed, Linus
suggested everyone compile there kernels out of /home in the last
discussion about this.

Admittedly it should not be linked, but I think it is often enough - the
same rule stands: don't change the src without recompiling glibc.

	Robert Love

