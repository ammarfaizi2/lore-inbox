Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293151AbSCOSwK>; Fri, 15 Mar 2002 13:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSCOSv5>; Fri, 15 Mar 2002 13:51:57 -0500
Received: from um.es ([155.54.1.1]:56968 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S293132AbSCOSvt>;
	Fri, 15 Mar 2002 13:51:49 -0500
Message-ID: <3C9237BC.CB48D7CA@ditec.um.es>
Date: Fri, 15 Mar 2002 19:04:44 +0100
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.78 [es] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: VGA blank causes hang with 2.4.18
In-Reply-To: <200203150252.g2F2qVM15051@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch escribió:
> 
>   Hi, all. Here's a perverse problem: when the screen blanks (text
> console) with 2.4.18, the machine hangs. No ping response, no magic
> SysReq response. I didn't have this problem with 2.4.7.
> 
> The command I used to configure screen blanking was:
> setterm -blank 10 -powerdown 0
> 
> This is an Athalon 850 MHz on a Gigabyte GA-7ZM motherboard.
> 
> I managed to waste a few hours chasing this, wondering why the machine
> hung a while after boot. Of course, I first blamed the jobs that were
> started on it soon after boot. Turns out the jobs are not to blame!
> 
>                                 Regards,
> 
>                                         Richard....

I have had a similar problem for a long time with different versions of
Linux kernel. 
This problem rarely occurs and it always does when I am in a text
console. MagicSysRq does not help :-(.

Bye!!!!
-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index

*** Por favor, envíeme sus documentos en formato texto, HTML, PDF o
PostScript :-) ***
