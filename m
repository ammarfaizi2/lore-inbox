Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268210AbTALDcJ>; Sat, 11 Jan 2003 22:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268211AbTALDcJ>; Sat, 11 Jan 2003 22:32:09 -0500
Received: from xyzzy.bubble.org ([132.238.254.34]:42001 "EHLO xyzzy.bubble.org")
	by vger.kernel.org with ESMTP id <S268210AbTALDcI>;
	Sat, 11 Jan 2003 22:32:08 -0500
Message-ID: <3E20E3C7.208@xyzzy.bubble.org>
Date: Sat, 11 Jan 2003 22:40:55 -0500
From: Jeffrey Ross <jeff@xyzzy.bubble.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel OOPS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bear with me, this is my first attempt at sending the output of a kernel 
oops.  I believe I have all the desired information.  Here goes...

The system appears to randomly lock up, with X running, without X 
running etc.  it appears to be occuring whenever the CD drives are accessed.

The multi question form:

[1-3] I'm not sure exactly how to answer
[4] Linux version 2.4.21-pre3-ac3 (root@wisdom2) (gcc version 3.2 
20020903 (Red Hat
Linux 8.0 3.2-7)) #6 Sat Jan 11 14:29:12 EST 2003
[5] see http://www.bubble.org/~jeff/crash.tar.gz (includes console 
output from bootup until the crash plus everything asked for in 
"oops-tracing.txt" (I think)
[6] I don't think its possible
[7] not sure ??
[7.X] all files are included in the tar file

I've tried to make the contents of the files self explanitory.

Although I'm not a programmer, I am willing to help out in any way I can 
to find and squash this problem.

Other information...

System Motherboard is an Intel Model# D845GBV the BIOS is the dated 
November 20,2002 on Intel's website.

Both CDrom drivers are IDE and I'm using the IDE to scsi shim.

Jeff

