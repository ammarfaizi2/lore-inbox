Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263015AbREWJBH>; Wed, 23 May 2001 05:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbREWJA5>; Wed, 23 May 2001 05:00:57 -0400
Received: from nw177.netaddress.usa.net ([204.68.24.77]:54764 "HELO
	nw177.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S263015AbREWJAs> convert rfc822-to-8bit; Wed, 23 May 2001 05:00:48 -0400
Message-ID: <20010523090046.13756.qmail@nw177.netaddress.usa.net>
Date: 23 May 2001 03:00:46 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Re: __asm__ ]
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David
                   Thanks for the reply. I am sorry that I misspelled the
line(__asm__(....)). It is from the get_current() function in
asm-i386/current.h. But I am not clear what is the whole meaning of that
line(__asm__(..)) in get_current(). I am doing a project in Linux related to
VFS. From VFS. this function is called to get the base of the file system. I
am not getting how this function will gave the base of the file system.
get_current() is called from lookup_dentry function.
             base=dget(current->fs->root)
 
Thanks in advance
                         by
                           Blesson

____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
