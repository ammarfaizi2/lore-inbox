Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262936AbSJAXEH>; Tue, 1 Oct 2002 19:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262950AbSJAXEH>; Tue, 1 Oct 2002 19:04:07 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:60898 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S262936AbSJAXEH>; Tue, 1 Oct 2002 19:04:07 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEEC@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
       "Grover, Andrew" <andrew.grover@intel.com>
Cc: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, hpa@zytor.com, cpufreq@www.linux.org.uk
Subject: RE: cpufreq patches for 2.5.39 follow
Date: Tue, 1 Oct 2002 16:07:56 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@suse.cz] 
> > Mobile Celerons do not support voltage scaling.
> But they can do frequency changes, right? And frequency is what
> cpufreq is about, AFAICS. [I do not think k6 supports voltage scaling,
> either. And ARM machines can't do voltage scaling, too.]

Well, you can throttle them, but AFAIK that's it.

Why do you think they are cheaper? They don't got no special sauce!

:)

-- Andy
