Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135183AbRDROFC>; Wed, 18 Apr 2001 10:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135184AbRDROEx>; Wed, 18 Apr 2001 10:04:53 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:39435
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S135183AbRDROEl> convert rfc822-to-8bit; Wed, 18 Apr 2001 10:04:41 -0400
Date: Wed, 18 Apr 2001 10:03:50 -0400
From: Chris Mason <mason@suse.com>
To: Jaquemet Loic <jal@fleming.u-psud.fr>, linux-kernel@vger.kernel.org
Subject: Re: VFS problem
Message-ID: <150220000.987602630@tiny>
In-Reply-To: <3ADD7E03.F8ED7F83@fleming.u-psud.fr>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, April 18, 2001 01:44:04 PM +0200 Jaquemet Loic
<jal@fleming.u-psud.fr> wrote:

> Jaquemet Loic a écrit :
> >> Sorry if this problem has already been disscussed.
>> >> I run an linux box with a HD 30Go/reiserfs .
>> I tried several 2.4 kernel ( 2.4.2 , 2.4.3 , 2.4.4-pre3 , 2.4.3-ac7)
>> After a random time I've got a fs problem which lead to :
>> -first a segfault of a process which reads/writes on the partition
>> ex:
>> [jal@skippy prog]$ ./configure
>> ....
>> ln -s dialects/linux/machine.h machine.h
>> Erreur de segmentation ( SEGFAULT )
>> >> -and then the partition freeze .Any attempt to read/write on it leads to


Hmmm, are you sure there aren't any reiserfs messages on screen or in the
log?

-chris



