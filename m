Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbSIXOHI>; Tue, 24 Sep 2002 10:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbSIXOHI>; Tue, 24 Sep 2002 10:07:08 -0400
Received: from pop.gmx.de ([213.165.64.20]:12882 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261682AbSIXOHH>;
	Tue, 24 Sep 2002 10:07:07 -0400
Message-ID: <3D9072B8.5090106@gmx.at>
Date: Tue, 24 Sep 2002 16:12:08 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Petr Slansky <slansky@usa.net>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: hpt370 raid driver
References: <20020924132445Z261665-8740+289@vger.kernel.org> <1032875703.2607.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2002-09-24 at 15:29, Petr Slansky wrote:
> 
>>Hi Alan!
>>do you know that there is a source code of driver for HPT370 raid at the
>>manufacturer web?
>>
>>http://www.highpoint-tech.com/370drivers_down.htm
>>http://www.highpoint-tech.com/hpt3xx-opensource-v13.tgz
>>
>>Maybe that this can be added to the kernel, there are many motherboards on the
>>market with such controller onboard. Is there any poblem with this driver?
> 
> 
> It's a binary only driver with some glue code.... not open source.

The header files are good. They show the structure of the raid signature 
and some info about the event logs. They could be reused by the linux 
module, however I do not know if the copyright is a problem there. Does 
anyone know...?

Bye,
Wilfried

-- 
Ing. Wilfried Weissmann               mailto: Wilfried.Weissmann@gmx.at
Benedikt-Schellingergasse 18/19a      Tel.: +43 1 78 64 739
1150 Wien                             Mobil: +43 676 944 44 65

