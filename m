Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291022AbSBXUDb>; Sun, 24 Feb 2002 15:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291020AbSBXUDW>; Sun, 24 Feb 2002 15:03:22 -0500
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:20646 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S291026AbSBXUDJ>; Sun, 24 Feb 2002 15:03:09 -0500
Message-ID: <3C794665.8080805@wanadoo.fr>
Date: Sun, 24 Feb 2002 21:00:37 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Heinz Diehl <hd@cavy.de>
CC: Mike Fedyk <mfedyk@matchmail.com>, Chris Sykes <chris@sykes.uklinux.net>,
        linux-kernel@vger.kernel.org
Subject: Re: floppy in 2.4.17
In-Reply-To: <20020223160544.A1905@werewolf.able.es> <20020223184916.GA1518@chiara.cavy.de> <20020223220007.A461@cooper> <20020224030528.GQ20060@matchmail.com> <20020224134608.GA168@chiara.cavy.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heinz Diehl wrote:
> On Sat Feb 23 2002, Mike Fedyk wrote:
> 
> 
>>So, can you guys stress the -ac patch to see if it's fixed there?
>>
> 
> chiara:~ # mke2fs -t ext2 /dev/fd0

# mke2fs /dev/fd0 might work better

> mke2fs 1.24, 30-Aug-2001 for EXT2 FS Lö,
> mke2fs: bad blocks count - /dev/fd0
> 
> chiara:~ # uname -a
> Linux chiara 2.4.18-rc2-ac1 #1 Sun Feb 24 14:20:33 CET 2002 i586 unknown
> 	
> 



-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

