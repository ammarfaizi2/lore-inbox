Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbSLRVz6>; Wed, 18 Dec 2002 16:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbSLRVz5>; Wed, 18 Dec 2002 16:55:57 -0500
Received: from vsmtp3.tin.it ([212.216.176.223]:30905 "EHLO smtp3.cp.tin.it")
	by vger.kernel.org with ESMTP id <S267359AbSLRVza>;
	Wed, 18 Dec 2002 16:55:30 -0500
Message-ID: <3E00F161.8090501@tin.it>
Date: Wed, 18 Dec 2002 23:06:25 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Reiser <jreiser@BitWagon.com>
CC: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       black666@inode.at
Subject: Re: IDE-CD and VT8235 issue!!!
References: <3DFB7B21.7040004@tin.it> <3DFBC4F3.2070603@tin.it> <20021215215057.A12689@ucw.cz> <200212152256.25266.black666@inode.at> <20021216113458.A31837@ucw.cz> <3DFDD2FC.2030700@tin.it> <20021216141945.A32729@ucw.cz> <3DFDDF8C.8030609@tin.it> <20021218100338.B15267@ucw.cz> <3E00EE72.1020506@BitWagon.com>
In-Reply-To: <3E00EE72.1020506@BitWagon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Reiser wrote:

> Vojtech Pavlik wrote:
>
>> One more here, if you can try it (and remove the two previous ones
>> first).
>
>
> The earlier vt8235-dvd patch worked for me, but the later vt8235-min 
> did not.
>
> Mitsumi FX4830T ATAPI CD-ROM, MSI KT3 Ultra2 (KT333) mainboard, vt8235.
> -----
> kernel: hdc: status error: status=0x58 { DriveReady SeekComplete 
> DataRequest }
> kernel: hdc: drive not ready for command
> kernel: hdc: status timeout: status=0xd1 { Busy }
> kernel: hdc: DMA disabled
> kernel: hdc: drive not ready for command
> kernel: hdc: ATAPI reset complete
> kernel: hdc: status timeout: status=0xd1 { Busy }
> kernel: hdc: drive not ready for command
> -----

Hunks error? during the patching?

byez

Marcello


