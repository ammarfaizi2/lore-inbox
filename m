Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTAMLUU>; Mon, 13 Jan 2003 06:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbTAMLUU>; Mon, 13 Jan 2003 06:20:20 -0500
Received: from ca-metz-1-173.abo.wanadoo.fr ([80.8.112.173]:36873 "EHLO
	xiii.freealter.fr") by vger.kernel.org with ESMTP
	id <S267107AbTAMLUT>; Mon, 13 Jan 2003 06:20:19 -0500
Message-ID: <3E22A2E4.2000604@freealter.com>
Date: Mon, 13 Jan 2003 12:28:36 +0100
From: Ludovic Drolez <ludovic.drolez@freealter.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: BLKBSZSET still not working on 2.4.18 ?
References: <3E1EE7A3.1050401@freealter.com> <20030110161331.GA19942@win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> You can test 2.5. If it is wrong there I must submit a patch.
> Andries

It seems to work perfectly with 2.5.56 even without using the BLKBSZSET 
ioctl.
But, I'm still reluctant to use an unstable kernel for backuping a 
partition. But maybe the 2.5 is stable enough to read blocks from 
IDE/SCSI drives, and send them over NFSv2 / IPv4 ?

Cheers,

-- 
Ludovic DROLEZ                                       Free&ALter Soft
152, rue de Grigy - Technopole Metz 2000                  57070 METZ
tel : 03 87 75 55 21                            fax : 03 87 75 19 26

