Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267195AbTAKL7i>; Sat, 11 Jan 2003 06:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbTAKL7i>; Sat, 11 Jan 2003 06:59:38 -0500
Received: from khms.westfalen.de ([62.153.201.243]:57784 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S267195AbTAKL7h>; Sat, 11 Jan 2003 06:59:37 -0500
Date: 11 Jan 2003 11:18:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8deE8FwHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0301081300200.1497-100000@home.transmeta.com>
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.44.0301081300200.1497-100000@home.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 08.01.03 in <Pine.LNX.4.44.0301081300200.1497-100000@home.transmeta.com>:

> On Wed, 8 Jan 2003, John Levon wrote:
> > On Wed, Jan 08, 2003 at 12:28:23PM -0800, Linus Torvalds wrote:

> > > or could even be a user program config file option.
> >
> > Eww.
>
> And it's less disgusting than adding a kernel hack for it?

>From my point of view as both user and programmer: about a hundred times  
less disgusting. (Also probably needs at least ten (maybe a hundred) times  
less code, including the kernel code, which plays a big part in the  
"disgusting" value.)

MfG Kai
