Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbUKNSj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUKNSj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 13:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbUKNSj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 13:39:29 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:19821 "EHLO
	mwinf1007.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261329AbUKNSjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 13:39:24 -0500
Message-ID: <4197A6AA.9000303@wanadoo.fr>
Date: Sun, 14 Nov 2004 19:40:42 +0100
From: mahashakti89 <mahashakti89@wanadoo.fr>
Reply-To: mahashakti89@wanadoo.fr
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr, en-us, de-de
MIME-Version: 1.0
To: Norbert van Nobelen <Norbert@edusupport.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syscontrol activation = problem on boot
References: <4197977B.5080400@wanadoo.fr> <200411141848.16106.Norbert@edusupport.nl>
In-Reply-To: <200411141848.16106.Norbert@edusupport.nl>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert van Nobelen a écrit :
> I have similar errors, but they don't give me any problems (except that it 
> looks bad).
> Can you mount and use the harddisk?

Yes !
No problems
> 
> Regards,
> 
> Norbert
> 
> On Sunday 14 November 2004 18:35, mahashakti89 wrote:
> 
>
>>But on boot I become following error message concerning
>>my second harddisk (/dev/hdb) which is dedicated to my
>>old Win2k system :
>>
>>  Nov 12 19:15:13 ishwara kernel: hdb: read_intr: status=0x59 {
>>DriveReady SeekComplete DataRequest Error }
>>
>> > Nov 12 19:15:13 ishwara kernel: hdb: read_intr: error=0x04 {
>>
>>DriveStatusError }
>>
>> > Nov 12 19:15:13 ishwara kernel: ide: failed opcode was: unknown
>> > Nov 12 19:15:13 ishwara kernel: end_request: I/O error, dev hdb,
>>
>>sector 78172098
>>
>> > Nov 12 19:15:13 ishwara kernel: Buffer I/O error on device hdb5,
>>
>>logical block 61785735
>>
>>it can last two or three minutes and then I have accsess to my
>>Gnome Desktop.
>>
>>This arrives on a 2.6.7 or 2.6.9 kernel if I try to activate Sysctrl
>>in General Setup, if I deactivate it, I have not such error messages ....
>>
>>To resume it : Is it a bug ? Or did I make something wrong ? Forget some
>>options ?
>>
>>
>>System : Pentium 4 2,8Ghz
>>          Motherboard Asus P4P 800
>>          Chipset I865PE
>>          and two Maxtor ATA-Harddisks
>>
