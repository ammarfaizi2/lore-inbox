Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268886AbTBSFIx>; Wed, 19 Feb 2003 00:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268888AbTBSFIw>; Wed, 19 Feb 2003 00:08:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30729 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268886AbTBSFIw>;
	Wed, 19 Feb 2003 00:08:52 -0500
Message-ID: <3E53139B.1070102@pobox.com>
Date: Wed, 19 Feb 2003 00:18:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2.5.62]: 1/3: Make Ethernet 1000Mbit also a seperate,
 complete selectable submenu
References: <200302181350.49492.m.c.p@wolk-project.de>
In-Reply-To: <200302181350.49492.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about saving my fingers and making it CONFIG_NET_GIGE or something 
like that?

Other than the long config option, I'll apply your patch, it looks good 
to me.

	Jeff



