Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266634AbUBGFkk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 00:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266636AbUBGFkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 00:40:40 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:32157 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266634AbUBGFkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 00:40:39 -0500
Message-ID: <40247A63.1030200@namesys.com>
Date: Fri, 06 Feb 2004 21:40:51 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: the grugq <grugq@hcunix.net>
CC: Jamie Lokier <jamie@shareable.org>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net>
In-Reply-To: <40243F97.3040005@hcunix.net>
X-Enigmail-Version: 0.82.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extensive literature on how you can recover deleted files 
from media that has been erased a dozen times, but breaking encryption 
is harder.  It is more secure to not put the data on disk unencrypted at 
all is my point.....

Hans

the grugq wrote:

> Well, I think secure deletion should be an option for everyone. Using 
> encryption is a data hiding technique, you prevent people for 
> detemining what sort of data is being stored there. Now, admittedly I 
> dont know at what level the reiser4 encryption appears, but I would 
> think its safer to have complete erasure when a file deleted 
> regardless of how well protected its contents were.
>
> just a thought.
>


