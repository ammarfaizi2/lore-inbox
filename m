Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271845AbRIQQZV>; Mon, 17 Sep 2001 12:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271818AbRIQQZM>; Mon, 17 Sep 2001 12:25:12 -0400
Received: from unimur.um.es ([155.54.1.1]:22921 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S271809AbRIQQY6>;
	Mon, 17 Sep 2001 12:24:58 -0400
Message-ID: <3BA62575.E14C5808@ditec.um.es>
Date: Mon, 17 Sep 2001 18:31:49 +0200
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.77 [es] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ext3 journal on its own device?
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es> <E15j19N-0006Gh-00@mrvdom03.schlund.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger escribió:
> 
> > I have been browsing the Ext3 source (version 0.0.7a), and it seems
> > impossible to use a block device as an Ext3 journal. Is that true?.
> 
> As the actual version of ext3 is 0.99 you should consider an update....
> It is possible to have the ext3 journal on a second device with ext3 0.95 or
> higher.
> 
> Check out http://www.uow.edu.au/~andrewm/linux/ext3/ext3-usage.html
> 
> greetings
> 
> Christian Bornträger
Thanks.

But the problem is that I need to use Linux 2.2.19, and the latest Ext3
version for that kernel is 0.0.7a, isn't it?.


-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
