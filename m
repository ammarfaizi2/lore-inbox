Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282497AbRKZUrm>; Mon, 26 Nov 2001 15:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282505AbRKZUqG>; Mon, 26 Nov 2001 15:46:06 -0500
Received: from ns.suse.de ([213.95.15.193]:49928 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282503AbRKZUoh>;
	Mon, 26 Nov 2001 15:44:37 -0500
Date: Mon, 26 Nov 2001 21:44:36 +0100
From: Olaf Hering <olh@suse.de>
To: war <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 Bug (PPC)
Message-ID: <20011126214436.A16971@suse.de>
In-Reply-To: <3C02886D.8DB9D1B5@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3C02886D.8DB9D1B5@starband.net>; from war@starband.net on Mon, Nov 26, 2001 at 01:22:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, war wrote:

> This is the actual SCSI driver I need for the 7200/90.
> make[3]: *** [53c7,8xx.o] Error 1

Are you sure about that one? Pick the new sym53c8xx_2 driver. 


Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
