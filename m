Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTB1Cyt>; Thu, 27 Feb 2003 21:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTB1Cyt>; Thu, 27 Feb 2003 21:54:49 -0500
Received: from d174.dhcp212-198-223.noos.fr ([212.198.223.174]:50363 "EHLO
	picsou.chatons") by vger.kernel.org with ESMTP id <S267427AbTB1Cyt>;
	Thu, 27 Feb 2003 21:54:49 -0500
Message-ID: <3E5ED1DA.3090808@ens.fr>
Date: Fri, 28 Feb 2003 04:04:58 +0100
From: David Monniaux <David.Monniaux@ens.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: fr, fr-FR, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: C-Media 9739 codec - solution found
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a solution at last...

C-Media proposes a Linux driver at
http://www.cmedia.com.tw/driver/Linux/Ac97/cmaudio-034.tar.gz

This driver works well with 2.4.20.

Who maintains the i810_audio / AC97-related things? I think the C-Media 
driver should be folded into the regular kernel (otherwise it won't get 
maintained).

Regards,
D. Monniaux

