Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271630AbRHUKOt>; Tue, 21 Aug 2001 06:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271634AbRHUKOj>; Tue, 21 Aug 2001 06:14:39 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:51843 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S271630AbRHUKOe>; Tue, 21 Aug 2001 06:14:34 -0400
Message-ID: <3B823476.9060109@korseby.net>
Date: Tue, 21 Aug 2001 12:14:14 +0200
From: Kristian <kristian@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: de, en
MIME-Version: 1.0
To: cwidmer@iiic.ethz.ch
CC: linux-kernel@vger.kernel.org
Subject: Re: massive filesystem corruption with 2.4.9
In-Reply-To: <3B821509.8000006@korseby.net> <200108210834.f7L8Ysk09023@mail.swissonline.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Widmer wrote:
> i had similar problems with 2.4.6. unfortunately i didn't save the errors so
> i can't compare the msg's. i just can say that with 2.4.6 it destroyed the
> ext2 on a 40GB and 60GB maxtor disk. since then my nfs server is running 
> 2.2.19 with works fine (with minor promblems*).
> 
> * after a client mounted an exprots once. i cant unmount that partition on 
> the server after the client unmounted the exports.

I have several entries more in my logfile. It would be no problem collecting 
them if that is helpful. I forgot to say that I'm using an IBM 41 GB (hda: 
IBM-DTLA-305040, ATA DISK drive) and that this problem only occurs on my 
root-partition (hda5), the always mounted /boot-Partition (hda1) and partially 
mounted misc-Partition (hda7) are not effected.

I don't use any NFS.

Kristian

·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

