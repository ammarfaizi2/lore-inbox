Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280856AbRKYMq1>; Sun, 25 Nov 2001 07:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280857AbRKYMqQ>; Sun, 25 Nov 2001 07:46:16 -0500
Received: from AGrenoble-101-1-6-196.abo.wanadoo.fr ([80.11.197.196]:21120
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S280856AbRKYMqH> convert rfc822-to-8bit; Sun, 25 Nov 2001 07:46:07 -0500
Message-ID: <3C00E8EB.4060908@wanadoo.fr>
Date: Sun, 25 Nov 2001 13:49:47 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.13 Kernel and Ext3 vs Ext2
In-Reply-To: <E167ja2-0004fF-00@carbon.btinternet.com> <9tpiio$n4u$1@cesium.transmeta.com> <20011125224259.A4844@higherplane.net> <EXCH01SMTP011Np7vXe00002de9@smtp.netcabo.pt>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Maria Godinho de Matos wrote:


> My question is, which kernel version support the ext3 partition format?


2.4.15pre2 onwards

I would wait for 2.4.16 to be out though, or try 2.4.16pre1.

> ext3 had lots of advantages over 
> ext2, i choosen ext3!
> 
> I want to know whether i did the right or the wrong thing, and which are the 
> main differences between these two types!!!


Well ext3 is a journalled file system... See 
http://www.linuxdoc.org/LDP/LG/issue68/dellomodarme.html
for a good explanation of this.


> ha, and before saying goodbye, where can read the complete information about 
> each and every kernel release?


Read the Changelogs.
kernels released until yesterday :
ftp://ftp.kernel.org/pub/linux/kernel/testing/old/
from now on :
ftp://ftp.kernel.org/pub/linux/kernel/v2.4/testing/
ftp://ftp.kernel.org/pub/linux/kernel/v2.5/testing/

François

