Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSHHS2N>; Thu, 8 Aug 2002 14:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSHHS2N>; Thu, 8 Aug 2002 14:28:13 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.27]:29206 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S317851AbSHHS2M>; Thu, 8 Aug 2002 14:28:12 -0400
Message-ID: <3D52B914.8050007@xs4all.nl>
Date: Thu, 08 Aug 2002 20:31:48 +0200
From: Rik van Ballegooijen <sleightofmind@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: parse error in ext2_fs_sb.h
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

When i was compiling some stuff, i got this error:

Parse error before "u32"

in the file (2.5.30):

include/linux/ext2_fs_sb.h

I changed the u32 to __u32 and it worked. Is this a (proper) solution?

Rik


