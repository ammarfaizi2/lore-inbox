Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270523AbRIJLSG>; Mon, 10 Sep 2001 07:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270585AbRIJLR4>; Mon, 10 Sep 2001 07:17:56 -0400
Received: from [209.10.41.242] ([209.10.41.242]:12764 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S270523AbRIJLRr>;
	Mon, 10 Sep 2001 07:17:47 -0400
Message-ID: <3B9C9FF3.7E2770AB@iph.to>
Date: Mon, 10 Sep 2001 14:11:47 +0300
From: Ihar Filipau <philips@iph.to>
Organization: Enformatica Ltd. UK
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: COW fs (Re: Editing-in-place of a large file)
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu>
		<318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua>
		<3B9B80E2.C9D5B947@riohome.com>  <3B9B9917.DA1CC12F@riohome.com> <1000057292.1867.1.camel@nomade>
Content-Type: multipart/mixed;
 boundary="------------0F1AD8ECDCE782075C79E0C8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0F1AD8ECDCE782075C79E0C8
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit


	Is there any FS that have dynamic allocation?

	On one partition can reside a number of FSs and using only needed space? this
would be really cute - HD behaves just like RAM.

	Some FSs on partition just like number files on FS.
	In other words "File Systems' System".

	google and altavista both show nothing...

PS Interesting like academic task. Hm. Will invistigate.

Xavier Bestel wrote:
> 
> le dim 09-09-2001 at 18:30 John Ripley a _rit :
> 
> > /dev/sda6 - /tmp      -  210845 blocks,  17697 duplicates,  8.39%
> > /dev/sda7 - /var      -   32122 blocks,   5327 duplicates, 16.58%
> > /dev/sdb5 - /home     -  220885 blocks,  24541 duplicates, 11.11%
> > /dev/sdc7 - /usr      - 1084379 blocks, 122370 duplicates, 11.28%
> 
> How many of these blocks actually belong to file data ?
>
--------------0F1AD8ECDCE782075C79E0C8
Content-Type: text/x-vcard; charset=koi8-r;
 name="philips.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Ihar Filipau
Content-Disposition: attachment;
 filename="philips.vcf"

begin:vcard 
n:Filiapau;Ihar
tel;pager:+375 (0) 17 2850000#6683
tel;fax:+375 (0) 17 2841537
tel;home:+375 (0) 17 2118441
tel;work:+375 (0) 17 2841371
x-mozilla-html:TRUE
url:www.iph.to
org:Enformatica Ltd.;Linux Developement Department
adr:;;Kalinine str. 19-18;Minsk;BY;220012;Belarus
version:2.1
email;internet:philips@iph.to
title:Software Developer
note:(none)
x-mozilla-cpt:;18368
fn:Philips
end:vcard

--------------0F1AD8ECDCE782075C79E0C8--

