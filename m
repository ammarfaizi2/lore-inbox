Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSL2Sy5>; Sun, 29 Dec 2002 13:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSL2Sy5>; Sun, 29 Dec 2002 13:54:57 -0500
Received: from ermelo.utad.pt ([193.136.40.6]:54411 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S261333AbSL2Sy4>;
	Sun, 29 Dec 2002 13:54:56 -0500
Message-ID: <3E0F4526.9030702@alvie.com>
Date: Sun, 29 Dec 2002 18:55:34 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Rolland <rol@as2917.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5.53] So sloowwwww......
References: <00b701c2af4f$14ea1ec0$2101a8c0@witbe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Rolland wrote:

>Hello,
>
>I'm just playing a little bit with Kernel 2.5.53, and I've been 
>afraid of finding it quite slow...
>
>  
>
Just to be sure, have you got DMA enabled on your disks ?

What is the result of:

# hdparm -i /dev/hda
# hdparm -i /dev/hdb


-- 

Álvaro Lopes 
---------------------
A .sig is just a .sig


