Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271714AbRJETx5>; Fri, 5 Oct 2001 15:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRJETxr>; Fri, 5 Oct 2001 15:53:47 -0400
Received: from [194.213.32.137] ([194.213.32.137]:6016 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S271714AbRJETxc>;
	Fri, 5 Oct 2001 15:53:32 -0400
Date: Fri, 5 Oct 2001 21:18:10 +0200
From: Pavel Machek <pavel@Elf.ucw.cz>
To: Alex Larsson <alexl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Directory notification problem
Message-ID: <20011005211810.B1272@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0110022206100.29931-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110022206100.29931-100000@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.22i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I discovered a problem with the dnotify API while fixing a FAM bug today.
> 
> The problem occurs when you want to watch a file in a directory, and that 
> file is changed several times in the same second. When I get the directory 

Does this mean that we have notification API in Linus' tree?
									Pavel
