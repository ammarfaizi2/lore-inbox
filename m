Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRJONMK>; Mon, 15 Oct 2001 09:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277165AbRJONMA>; Mon, 15 Oct 2001 09:12:00 -0400
Received: from iliade.campus.uniroma2.it ([160.80.1.66]:53764 "EHLO
	lisa.rhpk.springfield.inwind.it") by vger.kernel.org with ESMTP
	id <S273213AbRJONL6>; Mon, 15 Oct 2001 09:11:58 -0400
Date: Mon, 15 Oct 2001 15:06:42 +0200 (CEST)
From: Cristiano Paris <c.paris@libero.it>
To: <linux-kernel@vger.kernel.org>
Subject: libz, libbz2, ramfs and cramfs
Message-ID: <Pine.LNX.4.33.0110151436040.755-100000@lisa.rhpk.springfield.inwind.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

I'm interested in developing a file system which could take features from
ramfs and cramfs so I have a couple of questions which possibly Linus
would answer to.

First, what is the current status of these modules ? Are new features
currently being developed ?

Second, quoting from the jffs2's TODO list :

- fix zlib. It's ugly as hell and there are at least three copies in the
kernel tree

What is the current status of zlib ?

Third, is there any project which tries to implement bzip2 algorithm
inside the kernel ? Does it give better compression ratios on 1-page-long
data ?

Thanks :-)

Cristiano

