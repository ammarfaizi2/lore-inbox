Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284973AbRLZWmP>; Wed, 26 Dec 2001 17:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285000AbRLZWmF>; Wed, 26 Dec 2001 17:42:05 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33153 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S284973AbRLZWl6>;
	Wed, 26 Dec 2001 17:41:58 -0500
Date: Wed, 26 Dec 2001 17:41:57 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: =?iso-8859-1?Q?Eliezer_dos_Santos_Magalh=E3es?= 
	<magalhaes@intime-net.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: writing device drivers
Message-ID: <20011226174157.A14542@havoc.gtf.org>
In-Reply-To: <F68qvDuJhqFo9iLG7c500010b4e@hotmail.com> <01c301c18e45$6e2dd6b0$6400000a@cyber>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <01c301c18e45$6e2dd6b0$6400000a@cyber>; from magalhaes@intime-net.com.br on Wed, Dec 26, 2001 at 05:42:16PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2001 at 05:42:16PM -0200, Eliezer dos Santos Magalhães wrote:
> where can I find a good paper , or something good that could teach me how to
> write device drivers ?? I really would like to know , mainly network device
> drivers , for example , how could I re-write the rtl8139 driver ?

For kernel 2.4, the -2nd- edition of _Linux Device Drivers_ is good, but
it doesn't cover nearly everything you need to know...  your best
reference is existing network driver source code for recent PCI drivers.

And, are you having problems with rtl8139 or was that just an example?  :)

	Jeff


