Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145035AbRA2CxD>; Sun, 28 Jan 2001 21:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145008AbRA2Cwx>; Sun, 28 Jan 2001 21:52:53 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:15303 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S144997AbRA2Cwp>; Sun, 28 Jan 2001 21:52:45 -0500
Date: Mon, 29 Jan 2001 03:52:43 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Pierfrancesco Caci <p.caci@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: troubles with devfs ?
Message-ID: <20010129035243.J1173@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <87r91nbnin.fsf@penny.ik5pvx.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <87r91nbnin.fsf@penny.ik5pvx.ampr.org>; from ik5pvx@penny.ik5pvx.ampr.org on Sun, Jan 28, 2001 at 06:21:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 06:21:52PM +0100, Pierfrancesco Caci wrote:
> 
> This happens on a freshly booted 2.4.0 macine, with devfs and devfsd
> running.
> 
> I got the oops by doing
> # cd /dev
> # ls -las
> (segmentation fault)
> 
> The first oops causes the death of devfsd.

No such problems here and cannot reproduce this behavior. But I
have no real SCSI adaptor. Only ide-scsi and imm (Iomega-ZIP+).

So this might be an SCSI-Issue...

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
