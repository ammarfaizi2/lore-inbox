Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280790AbRKTAS7>; Mon, 19 Nov 2001 19:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280801AbRKTASv>; Mon, 19 Nov 2001 19:18:51 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:39951 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S280790AbRKTASg>; Mon, 19 Nov 2001 19:18:36 -0500
Date: Mon, 19 Nov 2001 16:18:40 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <Pine.LNX.4.33.0111191543390.19585-200000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111191608190.30692-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a related note, the files "/usr/src/linux/Documentation/filesystems/proc.txt"
and "sysctl/vm.txt" refer to some variables I need to be able to set on a
system running 2.4.12. In particular, I need to be able to get to the values
in "/proc/sys/vm/freepages", "/proc/sys/vm/buffermem" and
"/proc/sys/vm/pagecache". However, despite their existence in the documentation
files, these files don't exist on a 2.4.12 system. How can I read and set these
values on a 2.4.12 system?
--
znmeb@aracnet.com (M. Edward Borasky) http://www.aracnet.com/~znmeb
Relax! Run Your Own Brain with Neuro-Semantics!
http://www.meta-trading-coach.com

"Outside of a dog, a book is a man's best friend.  Inside a dog, it's
too dark to read." -- Marx

