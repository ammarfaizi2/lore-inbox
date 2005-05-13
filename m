Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVEMTpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVEMTpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVEMTpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:45:03 -0400
Received: from gw.c9x.org ([213.41.131.17]:35093 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S262506AbVEMTm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:42:56 -0400
Date: Fri, 13 May 2005 21:42:33 +0200
From: "Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: Andi Kleen <ak@muc.de>, gmicsko@szintezis.hu, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513194255.GA15388@c9x.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <20050513211609.75216bf8.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513211609.75216bf8.diegocg@gmail.com>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 09:16:09PM +0200, Diego Calleja wrote:
> However they've patched the FreeBSD kernel to "workaround?" it:
> ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/htt5.patch

  This patch just disables hyperthreading by default.
  
