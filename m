Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285000AbRLZWnZ>; Wed, 26 Dec 2001 17:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285007AbRLZWnR>; Wed, 26 Dec 2001 17:43:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38017 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S285000AbRLZWnH>;
	Wed, 26 Dec 2001 17:43:07 -0500
Date: Wed, 26 Dec 2001 17:43:07 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Arturas V <arturasv@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
Message-ID: <20011226174307.B14542@havoc.gtf.org>
In-Reply-To: <F1331RVM0t2CD7Lsb0O0001005d@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F1331RVM0t2CD7Lsb0O0001005d@hotmail.com>; from arturasv@hotmail.com on Wed, Dec 26, 2001 at 03:43:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2001 at 03:43:52PM -0500, Arturas V wrote:
> We had similar problems with Compaq Proliant XEON EEPro100 NIC and Compaq 
> Spart Array. System would periodically hang or panic. Problems went away 
> after I replaced EEPRO100 NIC with TLAN NICs(Texas instruments or 
> "Thunderland"). It's a good indication that there could be a problem with 
> eepro driver.

You not only replaced the driver but the hardware too.  So, that tells
us nothing about the eepro100 driver really.

	Jeff


