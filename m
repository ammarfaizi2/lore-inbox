Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266984AbUBGQv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266987AbUBGQv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:51:56 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:60410 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266984AbUBGQvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:51:53 -0500
Message-ID: <402517BC.50508@namesys.com>
Date: Sat, 07 Feb 2004 08:52:12 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: the grugq <grugq@hcunix.net>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org> <4024C5DF.40609@hcunix.net> <20040207110912.GB16093@mail.shareable.org> <4024D019.2080402@hcunix.net> <20040207120121.GE16093@mail.shareable.org>
In-Reply-To: <20040207120121.GE16093@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>
>   - Eraseable per-file keys may be a more secure way of destroying
>     data than overwriting data on a magnetic medium.
>
>
>  
>
I agree.
