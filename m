Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbRFVOTV>; Fri, 22 Jun 2001 10:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265431AbRFVOTL>; Fri, 22 Jun 2001 10:19:11 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:25618
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265426AbRFVOTF>; Fri, 22 Jun 2001 10:19:05 -0400
Date: Fri, 22 Jun 2001 10:18:35 -0400
From: Chris Mason <mason@suse.com>
To: Joachim Reichelt <Reichelt@gbf.de>, reiserfs-list@namesys.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock
Message-ID: <705600000.993219515@tiny>
In-Reply-To: <3B32FF8E.5030103@gbf.de>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, June 22, 2001 10:19:26 AM +0200 Joachim Reichelt
<Reichelt@gbf.de> wrote:

> Hallo all,
> 

> on the ncr is a DLT Tape
> 
> kernel is vanilla 2.4.4
> 
> once a month i get a deadlock of the whole system during backup.
> What can i do
>     to get the bug fixed
> or
>     to get not affected by it any longer

Well, can you tell which filesystem is being backed up when the system
deadlocks?

-chris

