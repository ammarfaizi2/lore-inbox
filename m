Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316505AbSEOWZf>; Wed, 15 May 2002 18:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316506AbSEOWZe>; Wed, 15 May 2002 18:25:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48653 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316505AbSEOWZe>; Wed, 15 May 2002 18:25:34 -0400
Message-ID: <3CE2E052.1010203@zytor.com>
Date: Wed, 15 May 2002 15:25:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Dead2 <dead2@circlestorm.org>
CC: Tigran Aivazian <tigran@veritas.com>, syslinux@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [syslinux] Re: Initrd or Cdrom as root
In-Reply-To: <Pine.LNX.4.33.0205141920420.1577-100000@einstein.homenet> <006601c1fbe6$d47594d0$0d01a8c0@studio2pw0bzm4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dead2 wrote:
> 
>>This is my isolinux.cfg file:
>>---
>>DEFAULT zoac
>>
>>LABEL zoac
>>    KERNEL /boot/bzImage
>>    APPEND "enableapic rootcd=1"
>>---
> 

Ditch the quotation marks!

	-hpa


