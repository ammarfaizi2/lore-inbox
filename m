Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVA1Rox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVA1Rox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVA1Rox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:44:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16133 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261491AbVA1Rku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:40:50 -0500
Date: Fri, 28 Jan 2005 18:40:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-ID: <20050128174046.GR28047@stusta.de>
References: <1106932637.3778.92.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1106932637.3778.92.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 06:17:17PM +0100, Lorenzo Hernández García-Hierro wrote:
>...
> As it's impact is minimal (in performance and development/maintenance
> terms), I recommend to merge it, as it gives a basic prevention for the
> so-called system fingerprinting (which is used most by "kids" to know
> how old and insecure could be a target system, many time used as the
> first, even only-one, data to decide if attack or not the target host)
> among other things.
>...

"basic prevention"?
I hardly see how this patch makes OS fingerprinting by e.g. Nmap 
impossible.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

