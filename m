Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281982AbRKUVa2>; Wed, 21 Nov 2001 16:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281983AbRKUVaS>; Wed, 21 Nov 2001 16:30:18 -0500
Received: from ns01.netrox.net ([64.118.231.130]:55205 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S281982AbRKUVaI>;
	Wed, 21 Nov 2001 16:30:08 -0500
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
	opcode
From: Robert Love <rml@tech9.net>
To: Jeff Merkey <jmerkey@timpanogas.org>
Cc: Doug Ledford <dledford@redhat.com>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <002201c172d1$ca81cc80$f5976dcf@nwfs>
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl>
	<002401c172ba$b46bed20$f5976dcf@nwfs>
	<20011121191607.A32418@fenrus.demon.nl>
	<002801c172c6$3e23a8e0$f5976dcf@nwfs> <3BFC1051.1050201@redhat.com> 
	<002201c172d1$ca81cc80$f5976dcf@nwfs>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 21 Nov 2001 16:28:41 -0500
Message-Id: <1006378131.1292.5.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-21 at 16:16, Jeff Merkey wrote:
> Which kernel version?  Neither NWFS or SCI will build against "stock"
> installed kernel sources provided with Seawolf.

You are using the kernel-source RPM and not the kernel SRPM, right? 
I've seen that mistake.  But, I've never seen a problem compiling
against kernel-source.

	Robert Love


