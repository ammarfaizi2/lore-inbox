Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbSAPU7T>; Wed, 16 Jan 2002 15:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287545AbSAPU7K>; Wed, 16 Jan 2002 15:59:10 -0500
Received: from dlezb.ext.ti.com ([192.91.75.132]:47345 "EHLO go4.ext.ti.com")
	by vger.kernel.org with ESMTP id <S287558AbSAPU66>;
	Wed, 16 Jan 2002 15:58:58 -0500
Message-ID: <3C45E98A.1020303@ti.com>
Date: Wed, 16 Jan 2002 21:58:50 +0100
From: christian e <cej@ti.com>
Organization: Texas Instruments A/S,Denmark
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: aa works for me..rrmap didn't
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all

An update yet again for those who may care.I tried both aa patch and 
rrmap patch and the aa patch works fine.I havent got any swap issues 
with that patch.The rrmap seemed ok in the beginning but then all hell 
broke loose and it swapped like map and my apps took minutes to start.
Sorry for the lack of details I haven't got time for further debugging :-(

Hopefully I'll get moere time soon and I'll gladly test again..For now I 
stick with 2.4.18pre2 with aa2 patch..

best regards

Christian

