Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUGNSb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUGNSb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 14:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUGNSbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 14:31:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21958 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265161AbUGNSb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 14:31:28 -0400
Message-ID: <40F57BF1.4010001@pobox.com>
Date: Wed, 14 Jul 2004 14:31:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Adrian Bunk <bunk@fs.tum.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       akpm@osdl.org, dgilbert@interlog.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
References: <200407141216.i6ECGHxg008332@harpo.it.uu.se> <40F556CE.9000707@pobox.com> <20040714164253.GE7308@fs.tum.de> <40F562FC.50806@pobox.com> <20040714165419.GF7308@fs.tum.de>
In-Reply-To: <20040714165419.GF7308@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, it would probably be better for some of these changes to simply be 
made non-inline.

	Jeff



