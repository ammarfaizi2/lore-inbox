Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314923AbSDVXKw>; Mon, 22 Apr 2002 19:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314924AbSDVXKv>; Mon, 22 Apr 2002 19:10:51 -0400
Received: from AGrenoble-101-1-3-34.abo.wanadoo.fr ([193.253.251.34]:4736 "EHLO
	elessar.linux-site.net") by vger.kernel.org with ESMTP
	id <S314923AbSDVXKu> convert rfc822-to-8bit; Mon, 22 Apr 2002 19:10:50 -0400
Message-ID: <3CC49A91.9090006@wanadoo.fr>
Date: Tue, 23 Apr 2002 01:19:45 +0200
From: =?ISO-8859-15?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: tomas szepe <kala@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PromiseULTRA100 TX2 ATA66 trouble
In-Reply-To: <Pine.LNX.4.44.0204222127100.2888-100000@louise.pinerecords.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tomas szepe wrote:

<snip>

> Furthermore, applying Andre Hedrick's ide-2.4.19-p7.all.convert.6.patch
> causes the kernel to not even recognize the controller. BUUUURN! <g>
> 
> The card is detected as:
> Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d68 (rev 02)

<snip>

Try convert.5 not convert.6
convert.6 doesn't recognize my Promise Ultra66 board either.

François Cami

