Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289124AbSAVBDK>; Mon, 21 Jan 2002 20:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289121AbSAVBDA>; Mon, 21 Jan 2002 20:03:00 -0500
Received: from [24.131.1.59] ([24.131.1.59]:26549 "EHLO
	mnmai05.mn.mediaone.net") by vger.kernel.org with ESMTP
	id <S289119AbSAVBCw> convert rfc822-to-8bit; Mon, 21 Jan 2002 20:02:52 -0500
From: Steve Brueggeman <brewgyman@mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon PSE/AGP Bug
Date: Mon, 21 Jan 2002 19:02:39 -0600
Message-ID: <hbep4uka8q6t1tfv6694sjtvfrulipg3a4@4ax.com>
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com>, <20020121.053724.124970557.davem@redhat.com>; from davem@redhat.com on Mon, Jan 21, 2002 at 05:37:24AM -0800 <20020121175410.G8292@athlon.random> <3C4C5B26.3A8512EF@zip.com.au> <o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com>
In-Reply-To: <o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention, I got the segfaults compiling kernels while running
linux-2.4.17, I was in console, and did not have Frame Buffer, or drm drivers
loaded.  I did have the SiS AGP compiled into the kernel though.

