Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289767AbSAOXsR>; Tue, 15 Jan 2002 18:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289766AbSAOXsH>; Tue, 15 Jan 2002 18:48:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34578 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289764AbSAOXry>; Tue, 15 Jan 2002 18:47:54 -0500
Message-ID: <3C44BF99.1030305@zytor.com>
Date: Tue, 15 Jan 2002 15:47:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16Qa0W-0001kH-00@starship.berlin> <3C448D8F.80606@zytor.com> <E16Qca1-0001lA-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> 
>>From the man page:
> 
>    "The new ASCII format is portable between
>    different machine architectures and can be used on any size file system,  but  is
>    not supported by all versions of cpio; currently, it is only supported by GNU and
>    Unix System V R4."

> 

... which, between them, is virtually all Unices these days.

	-hpa

