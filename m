Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSHGUgQ>; Wed, 7 Aug 2002 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSHGUgQ>; Wed, 7 Aug 2002 16:36:16 -0400
Received: from [200.213.197.161] ([200.213.197.161]:38536 "HELO
	hm61.locaweb.com.br") by vger.kernel.org with SMTP
	id <S317434AbSHGUgO>; Wed, 7 Aug 2002 16:36:14 -0400
Message-ID: <20020807203936.14257.qmail@hm36.locaweb.com.br>
From: "Renato" <webmaster@cienciapura.com.br>
Date: Wed,  7 Aug 2002 17:39:36
To: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       "Linux Kernel ML \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: Re: Hyperthreading Options in 2.4.19
References: <9EFD49E2FB59D411AABA0008C7E675C009D8DEE3@emss04m10.ems.lmco.com>
In-Reply-To: <9EFD49E2FB59D411AABA0008C7E675C009D8DEE3@emss04m10.ems.lmco.com>
X-Mailer: LocaWeb Mail
X-IPAddress: 200.182.81.199
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read a while back that the kernel boot parameter "idle=poll" helps to improve the wake up latency of processes in high 
performance systems.

On Wed, 07 Aug 2002 14:22:05 -0400, "Reed, Timothy A" <timothy.a.reed@lmco.com> escreveu :

> De: "Reed, Timothy A" <timothy.a.reed@lmco.com>
> Data: Wed, 07 Aug 2002 14:22:05 -0400
> Para: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
> Assunto: Hyperthreading Options in 2.4.19
> 
> Hello All,
> 	I am going rounds with a sub-contractor of ours about what options
> should and should not be compiled into the kernel in order for
> Hyperthreading to work.  Can anyone make any suggestions and comments to the
> options (below)  that I am planning on enforcing:
> 	MSR
> 	MTRR
> 	CPUID
> 
> 	Lilo.conf : acpismp=force?? 
> 
> 	Are the following worth any thing of value to Hyperthreading:
> 	Microcode
> 	ACPI
> 
> TIA
> 
> Timothy Reed
> Software Engineer/Systems Administrator
> Lockheed Martin - NE & SS Syracuse
> Email: timothy.a.reed@lmco.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
