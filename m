Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287139AbSASTgF>; Sat, 19 Jan 2002 14:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSASTfz>; Sat, 19 Jan 2002 14:35:55 -0500
Received: from hirogen.kabelfoon.nl ([62.45.45.69]:26375 "HELO
	hirogen.kabelfoon.nl") by vger.kernel.org with SMTP
	id <S287139AbSASTft>; Sat, 19 Jan 2002 14:35:49 -0500
Message-ID: <3C49CA26.6060503@kabelfoon.nl>
Date: Sat, 19 Jan 2002 20:33:58 +0100
From: Nick Martens <nickm@kabelfoon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hangs using opengl
In-Reply-To: <E16RMYE-0005OO-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Ok thanx all Another thing when it crashes the hd load seems extremely 
>>high. system config is Intel P3 1ghz, intel 815 chipset, kernel 2.4.5 
>>,xf86 4.1, kde 2.2
>>
> 
> How old is your 815 chipset ? I had problems with high load crashes on
> three 815 based boards all of which were the same (MX3S) and all of which
> went back.
> 
> Intel has errata on the 815 where the SDRAM voltage drive is apparently
> wrong and board level corrections to cope. I've never been able to find
> out if the board had these.
> 
> 
>>Jan 17 20:15:23 nick kernel: agpgart: unsupported bridge
>>Jan 17 20:15:23 nick kernel: agpgart: no supported devices found.
>>
> 
> How old is your kernel - and do you have both the 440BX and i81x AGP 
> included. The AGP on the i815 basically has two totally different worlds
> 1.	The rather nice onboard 2D/3D (i810 alike)
> 2.	When you plug in a video card (440 alike)
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I have rebuilt my kernel a few days ago,and my board is about one year (?) old 

one of the first series of the chaintech 6ojv boards


