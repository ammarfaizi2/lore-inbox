Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbTA2TUC>; Wed, 29 Jan 2003 14:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbTA2TUC>; Wed, 29 Jan 2003 14:20:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17934 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266805AbTA2TUB>; Wed, 29 Jan 2003 14:20:01 -0500
Message-ID: <3E382B81.3020400@zytor.com>
Date: Wed, 29 Jan 2003 11:29:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: kernel.org frontpage
References: <200301291914.h0TJEhsa002226@darkstar.example.net>
In-Reply-To: <200301291914.h0TJEhsa002226@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>>No, it would add absolutely nothing (other than clutter.)  All the .sign 
>>>files are good for is to check for rogue mirrors.
>>
>>Or a rogue *primary* site, as has already happened to OpenSSH and Sendmail.
> 
> 
> I see what you mean, but I don't see how it makes it any less useful
> to have them on the front page - if you download the latest kernel
> patch from a mirror, you could then just click on the relevant link on
> the front page of kernel.org - infact, as http access to kernel.org is
> frequently much slower than ftp, it might actually be very useful,
> because anybody downloading via http would make two requests, (OK,
> about 7, because of the images on the front page), instead of about
> 13, if they traverse each directory to the .sign file.
> 

No, just download the signature from the mirror and verify it.  This
isn't an MD5 signature.

	-hpa


