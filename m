Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbSJCOyC>; Thu, 3 Oct 2002 10:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbSJCOyC>; Thu, 3 Oct 2002 10:54:02 -0400
Received: from [203.117.131.12] ([203.117.131.12]:54252 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261575AbSJCOyB>; Thu, 3 Oct 2002 10:54:01 -0400
Message-ID: <3D9C5B4B.4050803@metaparadigm.com>
Date: Thu, 03 Oct 2002 22:59:23 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Kevin Corry <corryk@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
References: <02100216332002.18102@boiler> <20021003153256.B17513@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/02 22:32, Christoph Hellwig wrote:

>>version of EVMS was released. EVMS has been accepted into the
>>Debian (Woody and Sid versions)
> 
> 
> Can't find evms in my stock woody or sid kernel images.. (neither in the
> sarge ones, btw..)

Ships as a kernel patch deb as per most other debian kernel stuff that
isn't in mainline (debian kernel images are always unpatched mainline)

This is on my sid machine

$ apt-cache pkgnames | grep evms
evms-ncurses
libevms0
libevms1
evms-cli
evms-gui
kernel-patch-evms
libevms-dev
evms-lvmutils
evms

This is on one of my woody machines

$ apt-cache pkgnames | grep evms
evms-ncurses
libevms0
libevms1
evms-cli
evms-gui
kernel-patch-evms
libevms-dev
evms-lvmutils
evms

~mc

