Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTKER5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTKER5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:57:52 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:60098 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263009AbTKER5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:57:51 -0500
Date: Wed, 5 Nov 2003 15:57:48 -0200
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE disk information changed from 2.4 to 2.6
Message-ID: <20031105175748.GF5304@conectiva.com.br>
References: <20031105172310.GE5304@conectiva.com.br> <Pine.SOL.4.30.0311051827330.7079-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.SOL.4.30.0311051827330.7079-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 06:29:07PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> 
> On Wed, 5 Nov 2003, Flavio Bruno Leitner wrote:
> 
> > Upgrading from kernel 2.4 to 2.6 the CHS information for the same hardware
> 
> What are the exact kernel versions?

All versions up to 2.4.20 report the same information and 2.6 
is one snapshot from Linus bk 2003-10-29. 

I tested on another machine which the same chipset (but more recent
bk snapshot) and the behaviour is ok. I'm updating the kernel on 
the machine that reproduces this bug to see if happens again.


> > changed. This behaviour is correct?
> 
> I am just investigating it.

Thanks!


-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]
