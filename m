Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264949AbSJVT1c>; Tue, 22 Oct 2002 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264957AbSJVT1b>; Tue, 22 Oct 2002 15:27:31 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:37392 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264949AbSJVT0S>;
	Tue, 22 Oct 2002 15:26:18 -0400
Date: Tue, 22 Oct 2002 21:32:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Christoph Hellwig <hch@infradead.org>,
       Jan Kasprzak <kas@informatics.muni.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021022193226.GC26585@win.tue.nl>
References: <20021022185958.GB26585@win.tue.nl> <Pine.LNX.4.44L.0210221625440.27942-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210221625440.27942-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 04:26:35PM -0200, Marcelo Tosatti wrote:

> > No.  I do not claim that his problem was caused by the stats.
> > It is just that I get reports from people with mysterious mount
> > and fdisk problems that go away when CONFIG_BLK_STATS is disabled.
> 
> Could you forward?
> 
> Thats really bad.

The best reference is

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=35980

with fsck affected.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=62414

shows that mount is affected.

Andries
