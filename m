Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSGNJwm>; Sun, 14 Jul 2002 05:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSGNJwl>; Sun, 14 Jul 2002 05:52:41 -0400
Received: from ns.suse.de ([213.95.15.193]:27664 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315445AbSGNJwl>;
	Sun, 14 Jul 2002 05:52:41 -0400
Date: Sun, 14 Jul 2002 11:55:25 +0200
From: Dave Jones <davej@suse.de>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: Heinz Diehl <hd@cavy.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.25-dj2
Message-ID: <20020714115525.C28859@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Ben Clifford <benc@hawaga.org.uk>, Heinz Diehl <hd@cavy.de>,
	linux-kernel@vger.kernel.org
References: <20020713172627.GA5606@chiara.cavy.de> <Pine.LNX.4.44.0207131046510.5808-100000@barbarella.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207131046510.5808-100000@barbarella.hawaga.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 10:47:40AM -0700, Ben Clifford wrote:
 > -----BEGIN PGP SIGNED MESSAGE-----

 > >   ide-scsi24.c:847: unknown field abort' specified in initializer
 > >   ide-scsi24.c:847: warning: initialization from incompatible pointer type
 > >   ide-scsi24.c:848: unknown field reset' specified in initializer
 > >   ide-scsi24.c:848: warning: initialization from incompatible pointer type

Just kill those lines.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
