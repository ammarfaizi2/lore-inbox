Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132900AbRDQWAH>; Tue, 17 Apr 2001 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132901AbRDQV75>; Tue, 17 Apr 2001 17:59:57 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:17938 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S132900AbRDQV7u>; Tue, 17 Apr 2001 17:59:50 -0400
Message-ID: <3ADCBAA3.8F78775A@free.fr>
Date: Tue, 17 Apr 2001 23:50:27 +0200
From: Phil <philippe.amelant@free.fr>
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Ide performance (was RAID0 Performance problems)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15 Apr 2001 21:08:04 +0200, Andreas Peter a écrit :
> Hi,
> I've posted about performance problems with my RAID0 setup.
> RAID works fine, but it's too slow.

Hi

I have the same problem, but i think it 's a BX chipset related problem.

I Have a BP6 whit a BX chipset and a htp 366 chipset.
on a single device, hdparm report ~ 18/19 MB/s

with 2 devices on the same chipset (hda/hdc) 
hdparm report ~ 9 MB/s each

with 2 devices not on the same chipset (hda/hdg)
hdparm report ~ 16/17 MB/s
