Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293706AbSCKLdG>; Mon, 11 Mar 2002 06:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293704AbSCKLcy>; Mon, 11 Mar 2002 06:32:54 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:20487 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S293702AbSCKLcl>; Mon, 11 Mar 2002 06:32:41 -0500
Message-ID: <3C8C95D8.2070601@namesys.com>
Date: Mon, 11 Mar 2002 14:32:40 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Mark H. Wood" <mwood@IUPUI.Edu>
CC: no To-header on input <unlisted-recipients:@mangalore.zipworld.com.au;>,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.33.0203110508080.17717-100000@mhw.ULib.IUPUI.Edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark H. Wood wrote:

>On Sun, 10 Mar 2002, Itai Nahshon wrote:
>
>>On Sunday 10 March 2002 10:36, Hans Reiser wrote:
>>
>>>I think that if version control becomes as simple as turning on a plugin
>>>for a directory or file, and then adding a little to the end of a
>>>filename to see and list the old versions, Mom can use it.
>>>
>>IIRC that was a feature in systems from DEC even before
>>VMS (I'm talking about the late 70's).  eg. file.txt;2 was revision 2
>>of file.txt.
>>
>>I don't know if this feature was in the file-system or in the text editor
>>that I have used.
>>
>
>It's part of the TOPS-20 filesystem.  If you try to create a file which
>already exists, you get a new version of the file with length zero.  Each
>file has a version limit in its directory entry, and when the limit is
>exceeded the oldest version is automagically deleted.  The version limit
>is copied from the highest existing version to the new version, and the
>limit on the highest version determines whether old versions are dropped.
>
>
If it isn't optional (on per file and/or per directory basis) for users, 
it would be quite annoying.

Hans

