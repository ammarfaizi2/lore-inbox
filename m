Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262640AbSJBWbP>; Wed, 2 Oct 2002 18:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbSJBWbP>; Wed, 2 Oct 2002 18:31:15 -0400
Received: from 111-245-ADSL.red.retevision.es ([80.224.245.111]:15447 "EHLO
	quakers.net") by vger.kernel.org with ESMTP id <S262640AbSJBWau>;
	Wed, 2 Oct 2002 18:30:50 -0400
Message-ID: <3D9B75CA.3030504@eresmas.net>
Date: Thu, 03 Oct 2002 00:40:10 +0200
From: Manuel Clos <llanero@eresmas.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en, es-es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.5.40]: Various "sleeping function called ..." messages
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm not subscribed, so please CC me.

I got this messages at startup:

hda: DMA disabled
hdb: DMA disabled
...
Debug: sleeping function called from illegal context at slab.c:1374
...
Debug: sleeping function called from illegal context at slab.c:1374
...

dmesg > 2.5.40-boot.txt is at:

http://llanero.eresmas.net/kernel/2.5.40-boot.txt


-- 
Manuel Clos
llanero@eresmas.net

TCPA y Palladium: http://bulmalug.net/body.phtml?nIdNoticia=1398
TCPA and Palladium: http://www.cl.cam.ac.uk/~rja14/tcpa-faq.html

