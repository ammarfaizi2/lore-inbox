Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbTLHJoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 04:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265358AbTLHJoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 04:44:00 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:47368 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265357AbTLHJn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 04:43:58 -0500
Message-ID: <3FD44A6F.2060707@aitel.hist.no>
Date: Mon, 08 Dec 2003 10:54:55 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Large-FAT32-Filesystem Bug
References: <3FD0555F.5060608@gmx.de> <005301c3bb32$11a041a0$1225a8c0@kittycat> <20031207122650.GA30938@hh.idb.hist.no> <20031207122034.GA17042@irc.pl>
In-Reply-To: <20031207122034.GA17042@irc.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:
> On Sun, Dec 07, 2003 at 01:26:50PM +0100, Helge Hafting wrote:
> 
>>On Fri, Dec 05, 2003 at 05:17:00AM -0800, jdow wrote:
>>
>>>From: "Torsten Scheck" <torsten.scheck@gmx.de>
>>>
>>>>Dear friends:
>>>>
>>>>I already sent a message to the VFAT maintainer, but I decided
>>>>to additionally bother this list with a warning. This way some
>>>>readers might avoid data loss.
>>>
>>>This all may be moot. Microsoft is about to charge a royalty for
>>>use of the FAT file system. http://www.microsoft.com/mscorp/ip/tech/fat.asp
>>>
>>
>>The claim some patents, but aren't FAT so old that they have
>>expired?
> 
> 
> Patents for storing long names of files (which Microsoft is charging for)
> are from 1995 or something.
> 
No problem then - long filenames on fat is something I only see a need for
when sharing a partition with windows - you then have a licence to use
fat through the windows licence.

Digital cameras and such simply don't need long names.

Helge Hafting

