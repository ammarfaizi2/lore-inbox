Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267475AbUGNSoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUGNSoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 14:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbUGNSoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 14:44:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26317 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267459AbUGNSoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 14:44:19 -0400
Message-ID: <40F57EF6.5030702@pobox.com>
Date: Wed, 14 Jul 2004 14:44:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
       dgilbert@interlog.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
References: <200407141216.i6ECGHxg008332@harpo.it.uu.se> <40F562FC.50806@pobox.com> <20040714165419.GF7308@fs.tum.de> <200407141931.12249.bzolnier@elka.pw.edu.pl> <20040714183335.GG7308@fs.tum.de>
In-Reply-To: <20040714183335.GG7308@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch looks OK to me...

