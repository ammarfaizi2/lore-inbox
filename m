Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267882AbTBEJPU>; Wed, 5 Feb 2003 04:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267883AbTBEJPU>; Wed, 5 Feb 2003 04:15:20 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:7391 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S267882AbTBEJPT>; Wed, 5 Feb 2003 04:15:19 -0500
Message-ID: <3E40D830.3050502@bogonomicon.net>
Date: Wed, 05 Feb 2003 03:24:00 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Narsimha Reddy CHALLA <creddy@npd.hcltech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to install two linux OSes on the same PC
References: <3E418AD0.BC9F9765@npd.hcltech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not remembering much about the RH install, but have you tried using 
a console durring the early part of the installand repointing the mount 
points to where you want them?  This is a question that is best for 
RedHat's own lists.  I know this can be done as I've done it in the 
past.  It's been awhile since I've admined RedHat systems for 
developers.  I'm only admining Debian systems now.

- Bryan

Narsimha Reddy CHALLA wrote:
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hda1   *         1       261   2096451    6  FAT16
> /dev/hda2           262      2434  17454622+   5  Extended
> /dev/hda5           262       522   2096451    6  FAT16
> /dev/hda6           523       653   1052226   83  Linux
> /dev/hda7           654      1175   4192933+  83  Linux
> /dev/hda8          1176      1371   1574338+  83  Linux
> /dev/hda9          1372      1436    522081   82  Linux swap
> /dev/hda10         1437      1501    522081   83  Linux
> /dev/hda11         1502      1566    522081   83  Linux
> [root@creddy-pc root]#
> 
> 
> TIA,
> - Narsimha Reddy CH
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


