Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284321AbRLXBFW>; Sun, 23 Dec 2001 20:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284285AbRLXBFM>; Sun, 23 Dec 2001 20:05:12 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:34846 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284314AbRLXBFA>;
	Sun, 23 Dec 2001 20:05:00 -0500
Date: Mon, 24 Dec 2001 02:04:50 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011224010450.GB1482@moongate.thevoid.net>
In-Reply-To: <20011223025752.GA20445@moongate.thevoid.net> <Pine.LNX.4.33.0112230110110.5312-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112230110110.5312-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> none of that is meaningful (genuine companies ship invalid cables,
> and the 20 could easily have had a lower max udma mode, etc.)

hmmm, i'll try a new one after christmas... the bios showed them both as
'udma 66'.

> are they both on the same channel?  also, when you boot, do you see
> a message about the "athlon bug stomper"?  (which actually corrects 
> a bogus kt133/etal hostbridge setting.)

they are on the same channel. and i've never seen a message like this.

> I can't imagine any reason to use the preemption patch, since it
> completely corrupts all atomicity guarantees that the kernel has 
> been codd on.  there definitely is no problem with large disks and 
> via (and 80G is certainly not a large disk any more.)

well, plain 2.4.17 corrupted files, too.

bye
christian ohm
