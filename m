Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317695AbSFLMVZ>; Wed, 12 Jun 2002 08:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSFLMVY>; Wed, 12 Jun 2002 08:21:24 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:58890 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S317692AbSFLMVX>;
	Wed, 12 Jun 2002 08:21:23 -0400
Message-ID: <3D073C4D.3AAB1EED@torque.net>
Date: Wed, 12 Jun 2002 08:19:25 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: fdisk on scsi disks in 2.5.21
In-Reply-To: <UTC200206111251.g5BCpDN18038.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> > One head, one cylinder and lots of sectors??
> 
> > Is my fdisk (from RH 7.2) too old?
> 
> No, it is too modified.
> Get a vanilla fdisk from a recent util-linux,
> and probably all will be fine.
 
Andries,
Thanks. Confirming that the fdisk in util-linux-2.11r
works fine.

Doug Gilbert
