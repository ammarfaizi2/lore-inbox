Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRIYWBr>; Tue, 25 Sep 2001 18:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271514AbRIYWBa>; Tue, 25 Sep 2001 18:01:30 -0400
Received: from zape.um.es ([155.54.0.102]:17118 "EHLO zape.um.es")
	by vger.kernel.org with ESMTP id <S271832AbRIYWBW>;
	Tue, 25 Sep 2001 18:01:22 -0400
Message-ID: <3BB1005C.5C13A53F@ditec.um.es>
Date: Wed, 26 Sep 2001 00:08:28 +0200
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.77 [es] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bad, bad, bad VM behaviour in 2.4.10
In-Reply-To: <Pine.LNX.4.21.0109251702240.2193-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti escribió:
> 
> Juan,
> 
> It is a known problem which we are looking into.
> 
> I need some information which may help confirm a guess of mine:
> 
> Do you have swap available ?
Yes, the /dev/hda6 partition, that is 257000 KB in size.

> 
> If so, there was available anonymous memory to be swapped out ?

Anonymous memory? Sorry, but I do not understand this question. Could
you redo it?

Bye! 

-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
