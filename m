Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTEVPNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTEVPNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:13:51 -0400
Received: from mirapoint3.brutele.be ([212.68.203.242]:29468 "EHLO
	mirapoint3.brutele.be") by vger.kernel.org with ESMTP
	id S261568AbTEVPNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:13:50 -0400
Date: Thu, 22 May 2003 17:26:51 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Fabiano Sidler <fabianosidler@swissonline.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel unable to load modules
Message-ID: <20030522152651.GB11780@stargate.lan>
Mail-Followup-To: Fabiano Sidler <fabianosidler@swissonline.ch>,
	linux-kernel@vger.kernel.org
References: <200305221709.11147.fabianosidler@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200305221709.11147.fabianosidler@swissonline.ch>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux stargate.lan 2.4.20-gentoo-r5
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 05:09:09PM +0200, Fabiano Sidler wrote:
>> Hi all folks!
>> 
>> I hope I'm posting this to the right list:
>> Recently, I wanted to set up my box to kernel 2.4.20 and I built a kernel as I 
>> made it many times before. But from now on, my kernels are not longer able to 
>> load modules. Meanwhile I' ve built kernels with most of gcc versions (2.95.3 
>> - 3.3) and linux versions 2.4.18 - 20, but without any success. The modutils 
>> are up to date (gentoo .ebuild) and I removed the modules dir and ran 'make 
>> mrproper'.

With gcc 3.3, i have some errors, during the compilation, thus i stay with
my gcc 3.2.x 

About the .ebuild of Gentoo, there are not problems with them.

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
GPG ID : 1024D/C9C16DA7 | 5331 0B5B 21F0 0363 EACD  B73E 3D11 E5BC C9C1 6DA7


