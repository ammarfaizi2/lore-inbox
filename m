Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbREODDB>; Mon, 14 May 2001 23:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbREODCm>; Mon, 14 May 2001 23:02:42 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58820 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262607AbREODCa>;
	Mon, 14 May 2001 23:02:30 -0400
Message-ID: <3B009C43.AB2F4428@mandrakesoft.com>
Date: Mon, 14 May 2001 23:02:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mihaim@profm.ro
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel(R) PRO/100 Fast Ethernet Adapter in 2.4.4
In-Reply-To: <3790.193.230.227.44.989895072.squirrel@radio.protv.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mihai Moldovanu wrote:
> 
> In 2.4.2 the driver for this was e100.o
> Can someOne tell me wich one is in 2.4.4 ?

You need to download that from Intel, it's not in the official kernel
and never has been.  "eepro100" is the in-kernel driver for those series
of cards.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
