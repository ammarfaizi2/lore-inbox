Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUBJHSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUBJHSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:18:36 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:6872 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265682AbUBJHSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:18:02 -0500
Message-ID: <402885CD.3060303@namesys.com>
Date: Mon, 09 Feb 2004 23:18:37 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Shishkin <edward@namesys.com>
CC: Jamie Lokier <jamie@shareable.org>, the grugq <grugq@hcunix.net>,
       Valdis.Kletnieks@vt.edu, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org> <40251601.6050304@namesys.com> <40277807.6787981A@namesys.com>
In-Reply-To: <40277807.6787981A@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Shishkin wrote:

>
>Also they will demand this random number since the court can consider it
>as a part of your secret key. So just delete your secret key without creating
>meaningless infrastructure ;)
>Edward.
>  
>
This is a good point.  A court may be able to demand your pass phrase, 
but if you rm the key itself, they can hardly expect you to have 
memorized that.....
