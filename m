Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbTKJS0C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbTKJS0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:26:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7571 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264034AbTKJS0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:26:00 -0500
Message-ID: <3FAFD81D.5080605@pobox.com>
Date: Mon, 10 Nov 2003 13:25:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] give SATA its' own menu
References: <20031026001554.GC23291@fs.tum.de> <20031026011145.GB23690@vana.vc.cvut.cz> <20031110175842.GO22185@fs.tum.de>
In-Reply-To: <20031110175842.GO22185@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> I don't know the internals of the SATA driver, but this is unchanged 
> from the current dependencies.
> 
> If this is required, I can send a patch that adds disk an cdrom options 
> to SATA and select's the appropriate SCSI options.


If you didn't mind, such a patch would be nice...

	Jeff



