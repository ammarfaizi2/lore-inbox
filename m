Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278510AbRJ3Nn6>; Tue, 30 Oct 2001 08:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279794AbRJ3Nns>; Tue, 30 Oct 2001 08:43:48 -0500
Received: from dns.irisa.fr ([131.254.254.2]:1965 "HELO dns.irisa.fr")
	by vger.kernel.org with SMTP id <S278510AbRJ3Nna>;
	Tue, 30 Oct 2001 08:43:30 -0500
Date: Tue, 30 Oct 2001 14:44:06 +0100
From: DINH Viet Hoa <Viet-Hoa.Dinh@irisa.fr>
To: "Rajat Chadda" <rajat.chadda@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: How to write System calls?
Message-Id: <20011030144406.18a14fc2.vdinh@irisa.fr>
In-Reply-To: <a7f8aa4832.a4832a7f8a@wipro.com>
In-Reply-To: <a7f8aa4832.a4832a7f8a@wipro.com>
Organization: IRISA
X-Mailer: Sylpheed version 0.6.4claws12 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rajat Chadda" <rajat.chadda@wipro.com> wrote:

> Yes -- system calls can be implemented
> as modules.
> prog8.c is a module.
> prog9.c is a user-space program.
> 
> In <asm/unistd.h> -- add
> #define __NR_my_func            250 

thanks but my question was rather:
"in which case should we implement a new syscalls rather than a device
and a ioctl ?"

ie : what is better ? a new device and ioctl or new syscalls ?

and in which case, we should use one rather than the other ?

-- 
DINH Viêt Hoà, ingénieur associé, projet PARIS
IRISA-INRIA, Campus de Beaulieu, 35042 Rennes cedex, France
Tél: +33 (0) 2 99 84 75 98, Fax: +33 (0) 2 99 84 25 28
