Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbTABRbY>; Thu, 2 Jan 2003 12:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266246AbTABRbY>; Thu, 2 Jan 2003 12:31:24 -0500
Received: from franka.aracnet.com ([216.99.193.44]:22205 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266228AbTABRbW> convert rfc822-to-8bit; Thu, 2 Jan 2003 12:31:22 -0500
Date: Thu, 02 Jan 2003 09:39:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: uaca@alumni.uv.es,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_X86_TSC_DISABLE question
Message-ID: <124500000.1041529180@titus>
In-Reply-To: <20030102144409.GB8309@pusa.informat.uv.es>
References: <20030102144409.GB8309@pusa.informat.uv.es>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on your box. Most standard SMP boxes are all clocked off the
same clock, so it's not an issue.

--On Thursday, January 02, 2003 15:44:09 +0100 uaca@alumni.uv.es wrote:

> Hi all
>
> I would like to know if in wich degree the issue of unsynced TSCs also
> applies  on x86 SMP.
>
> Thanks
>
> 	Ulisses
>
>                 Debian GNU/Linux: a dream come true
> -------------------------------------------------------------------------
> ---- "Computers are useless. They can only give answers."
> Pablo Picasso
>
> --->	Visita http://www.valux.org/ para saber acerca de la	<---
> --->	Asociación Valenciana de Usuarios de Linux		<---
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


