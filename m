Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288206AbSAHSiP>; Tue, 8 Jan 2002 13:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288209AbSAHSiF>; Tue, 8 Jan 2002 13:38:05 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:3966 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288206AbSAHSh5>; Tue, 8 Jan 2002 13:37:57 -0500
Date: Tue, 8 Jan 2002 18:37:38 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Compile error 2.5.2-pre8 (ext3)
Message-ID: <20020108183738.A29468@grobbebol.xs4all.nl>
In-Reply-To: <20020105175727.A10286@rene-engelhard.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020105175727.A10286@rene-engelhard.de>
User-Agent: Mutt/1.3.22.1i
X-OS: Linux grobbebol 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 05:57:27PM +0100, Rene Engelhard wrote:
> Does anyone know what do do here now?
> I _have_ to compile the kernel with ext3 because / and all partitions
> are ext3...

ext3 partitions canb be mounted witout ext3 support. you only loose
journalling....

-- 
Grobbebol's Home                        |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel            | Use your real e-mail address   /\
Linux 2.4.17 (noapic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
