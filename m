Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbTFTVVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbTFTVVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:21:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55474 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264768AbTFTVVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:21:18 -0400
Message-ID: <3EF37E01.1000801@pobox.com>
Date: Fri, 20 Jun 2003 17:34:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Nicholas Wourms <nwourms@myrealbox.com>, linux-kernel@vger.kernel.org,
       jmorris@intercode.com.au, davem@redhat.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Breaking data compatibility with userspace bz2lib
References: <20030620185915.GD28711@wohnheim.fh-wedel.de> <20030620190957.GA19988@gtf.org> <3EF36E2C.3050906@myrealbox.com> <20030620205100.GE22732@wohnheim.fh-wedel.de>
In-Reply-To: <20030620205100.GE22732@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My bzlib initrd stuff was for 2.2.x era kernel, and was a 5-minute hack. 
  Don't assume thought was put into it, I just wanted something that 
worked :)  There are at least 3-4 bzlib patches floating around, all 
developed independently.  Mine, C Ludwig's, and a couple others.

	Jeff



