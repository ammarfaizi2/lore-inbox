Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030588AbWHIIpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbWHIIpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWHIIpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:45:05 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:35503 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1030588AbWHIIpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:45:03 -0400
Date: Wed, 9 Aug 2006 10:44:59 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Suspend on Dell D420
Message-ID: <20060809084459.GB1368@uio.no>
References: <20060804162300.GA26148@uio.no> <200608081604.00665.rjw@sisk.pl> <20060808150136.GA16272@uio.no> <200608081741.24099.rjw@sisk.pl> <20060809002159.GE4886@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060809002159.GE4886@elf.ucw.cz>
X-Operating-System: Linux 2.6.16trofastxen on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.12-2006-07-14
X-Spam-Score: -2.5 (--)
X-Spam-Report: Status=No hits=-2.5 required=5.0 tests=AWL,BAYES_00,NO_RELAYS version=3.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 02:21:59AM +0200, Pavel Machek wrote:
> Can you try with method=powerdown or method=reboot? BIOS black magic
> is not involved at least in reboot parts...

I lost you here; I've never heard of these options, nor does Google seem to.
Do I specify them on the kernel command line, or something else?

/* Steinar */
-- 
Homepage: http://www.sesse.net/
