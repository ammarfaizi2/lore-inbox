Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132829AbRDQXPi>; Tue, 17 Apr 2001 19:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbRDQXP2>; Tue, 17 Apr 2001 19:15:28 -0400
Received: from unthought.net ([212.97.129.24]:10907 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S132829AbRDQXPO>;
	Tue, 17 Apr 2001 19:15:14 -0400
Date: Wed, 18 Apr 2001 01:15:13 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Phil <philippe.amelant@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ide performance (was RAID0 Performance problems)
Message-ID: <20010418011513.B23123@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Phil <philippe.amelant@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <3ADCBAA3.8F78775A@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3ADCBAA3.8F78775A@free.fr>; from philippe.amelant@free.fr on Tue, Apr 17, 2001 at 11:50:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 11:50:27PM +0200, Phil wrote:
> Le 15 Apr 2001 21:08:04 +0200, Andreas Peter a écrit :
> > Hi,
> > I've posted about performance problems with my RAID0 setup.
> > RAID works fine, but it's too slow.
> 
> Hi
> 
> I have the same problem, but i think it 's a BX chipset related problem.

I have two SMP machines running RAID-0 on a BX chipset, without any
performance problems (~30-40 MB/sec on two disks, ~90MB/sec on five)

Kernel 2.4.3

> 
> I Have a BP6 whit a BX chipset and a htp 366 chipset.
> on a single device, hdparm report ~ 18/19 MB/s

Mine are Asus P2B-D boards

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
