Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWB1MNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWB1MNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWB1MNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:13:24 -0500
Received: from mail.dvmed.net ([216.237.124.58]:21637 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932478AbWB1MNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:13:22 -0500
Message-ID: <44043E5E.1060209@pobox.com>
Date: Tue, 28 Feb 2006 07:13:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com> <20060228114500.GA4057@elf.ucw.cz> <44043B4E.30907@pobox.com> <20060228120418.GB3695@elf.ucw.cz>
In-Reply-To: <20060228120418.GB3695@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Now, maybe message selection is neccessary, but having printk at
> begining of each function is not way to go.

Clearly you have not read much libata code at all...

	Jeff


