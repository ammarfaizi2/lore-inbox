Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273791AbRI0S0Z>; Thu, 27 Sep 2001 14:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273792AbRI0S0P>; Thu, 27 Sep 2001 14:26:15 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:10248 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S273791AbRI0SZ6>; Thu, 27 Sep 2001 14:25:58 -0400
Message-ID: <3BB36F4C.B33A517@delusion.de>
Date: Thu, 27 Sep 2001 20:26:20 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac16
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> 
> 2.4.9-ac16

Hi Alan,

Not really a big issue, but still worth mentioning:

In file included from /usr/src/linux-2.4.9-ac/include/linux/modversions.h:5,
                 from btaudio.c:1:
/usr/src/linux-2.4.9-ac/include/linux/modules/53c700.ver:1: warning: `__ver_NCR_700_detect' redefined
/usr/src/linux-2.4.9-ac/include/linux/modules/53c700-mem.ver:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.9-ac/include/linux/modules/53c700.ver:3: warning: `__ver_NCR_700_release' redefined
/usr/src/linux-2.4.9-ac/include/linux/modules/53c700-mem.ver:3: warning: this is the location of the previous definition

This is just one of many occurances.

-Udo.
