Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280599AbRKJKL4>; Sat, 10 Nov 2001 05:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280600AbRKJKLp>; Sat, 10 Nov 2001 05:11:45 -0500
Received: from two.fidnet.com ([205.216.200.52]:28013 "HELO mail.fidnet.com")
	by vger.kernel.org with SMTP id <S280599AbRKJKL3>;
	Sat, 10 Nov 2001 05:11:29 -0500
Message-ID: <3BECEEA2.4030408@hotmail.com>
Date: Sat, 10 Nov 2001 04:08:50 -0500
From: "Tim R." <omarvo@hotmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en, en-US, en-GB, es, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: nathans@sgi.com
Subject: [RFC][PATCH] extended attributes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm glad to see you guys are working on a common acl api for ext2/3 and xfs.
I was just wondering if this api provided what would be needed for linux 
to support NTFS's acls.
Now bare in mind I know little about how NTFS's alc's are implimented or 
if they follow POSIX at
all. But I just thought it might be worth asking the ntfs maintainer if 
the proposed api would be
adaquit to support ntfs's acls on linux should they ever want to 
impliment this. Might save them
headaches someday.
Also will it supply the interface needed for other filesystems that have 
been ported that linux that
support acls? (i.e. will it work for them, could they use it in the 
future if/when they decide to
impliment that feature) I think JFS might support acls too.

Sorry to be a bother,
Tim



