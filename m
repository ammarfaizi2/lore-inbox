Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315797AbSEEBc7>; Sat, 4 May 2002 21:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315810AbSEEBc6>; Sat, 4 May 2002 21:32:58 -0400
Received: from ool-182c923d.dyn.optonline.net ([24.44.146.61]:57731 "EHLO
	www.milanese.cc") by vger.kernel.org with ESMTP id <S315797AbSEEBc5>;
	Sat, 4 May 2002 21:32:57 -0400
Message-ID: <1020562447.3cd48c0f8e83c@www.milanese.cc>
Date: Sat,  4 May 2002 21:34:07 -0400
From: "Peter J. Milanese" <peterm@milanese.cc>
To: linux-kernel@vger.kernel.org
Subject: SMBfs / Unicode problem perhaps?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings-

 I don't know if this is just for my compile, or if this has been seen as a
problem yet. I recently set up 2.5.13, however the same issue persisted with
2.5.7 as well. I can successfully mount smbfs, however, it seems that the
directory contents are not translated correctly.

bash-2.04$ ls -la
ls: b: No such file or directory
ls: d: No such file or directory
ls: m: No such file or directory
ls: M: No such file or directory
ls: r: No such file or directory
ls: R: No such file or directory
ls: r: No such file or directory
ls: R: No such file or directory
ls: s: No such file or directory
ls: w: No such file or directory

Every 1st letter of the directory contents.

I could not find anything about this in the archive, and was curious as to
anyone else having this problem, and any input I could get-

Thanks

P

