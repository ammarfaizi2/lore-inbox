Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315884AbSEGV7H>; Tue, 7 May 2002 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSEGV7G>; Tue, 7 May 2002 17:59:06 -0400
Received: from jalon.able.es ([212.97.163.2]:35019 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315884AbSEGV7F>;
	Tue, 7 May 2002 17:59:05 -0400
Date: Tue, 7 May 2002 23:58:59 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Thomas Schenk <tschenk@origin.ea.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Has anyone integrated the e1000 driver into the 2.4.x kernel
Message-ID: <20020507215859.GA1728@werewolf.able.es>
In-Reply-To: <1020801852.26725.23.camel@bagend.origin.ea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.07 Thomas Schenk wrote:
>I am working a project where I need to be able to compile the Intel
>e1000 driver into a monolithic kernel, but the readme says that you can
>only use the driver as a module.  Is there some technical reason why
>this driver cannot be compiled into the kernel instead of being used as
>a module?
>

Backported from 2.5:

http://giga.cps.unizar.es/~magallon/linux/kernel/intel/

Apply both or you will get some rejects...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam1 #1 SMP mar may 7 22:23:30 CEST 2002 i686
