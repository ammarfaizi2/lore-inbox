Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUENR2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUENR2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUENR2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:28:44 -0400
Received: from florence.buici.com ([206.124.142.26]:9097 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261879AbUENR2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:28:40 -0400
Date: Fri, 14 May 2004 10:28:39 -0700
From: Marc Singer <elf@buici.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Message-ID: <20040514172839.GB18884@buici.com>
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <200405141852.25816.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405141852.25816.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 06:52:25PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> This code won't even compile it the current form:
> it uses ide_ioreg_t but I killed all users of ide_ioreg_t
> and obsoleted <asm/hdreg.h> braindamage.

I'm not suprised that it doesn't work.

Please point me to a righteous example.
