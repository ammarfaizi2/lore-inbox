Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbRENHgh>; Mon, 14 May 2001 03:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262032AbRENHg2>; Mon, 14 May 2001 03:36:28 -0400
Received: from nwcst284.netaddress.usa.net ([204.68.23.29]:9122 "HELO
	nwcst284.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S261840AbRENHfs> convert rfc822-to-8bit; Mon, 14 May 2001 03:35:48 -0400
Message-ID: <20010514073547.12678.qmail@nwcst284.netaddress.usa.net>
Date: 14 May 2001 01:35:47 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Re: Inodes]
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi J
                  You misunderstood my question. Let take an example.
Let I have a msdos partition. No msdos files has inode numbers, right. Let I
mount that msdos partition. Then what happens, That is my question. Will the
inode numbers are assigned to all msdos files at mounting time itself
Thanks for the reply
                   by
                      Blesson



J Sloan <jjs@mirai.cx> wrote:
Blesson Paul wrote:

> Hi
>                     This is an another doubt related to VFS. I want to know
> wheather all files are assigned their inode number at the mounting time
itself
> or inodes are assigned to files upon accessing only

er..

inode numbers are assigned at file creation time.

cu

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
