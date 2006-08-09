Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030592AbWHIJFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbWHIJFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030593AbWHIJFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:05:34 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:39619 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1030592AbWHIJFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:05:33 -0400
Date: Wed, 9 Aug 2006 11:05:30 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Suspend on Dell D420
Message-ID: <20060809090530.GA1633@uio.no>
References: <20060804162300.GA26148@uio.no> <200608081604.00665.rjw@sisk.pl> <20060808150136.GA16272@uio.no> <200608081741.24099.rjw@sisk.pl> <20060809002159.GE4886@elf.ucw.cz> <20060809084459.GB1368@uio.no> <20060809090208.GB3087@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060809090208.GB3087@elf.ucw.cz>
X-Operating-System: Linux 2.6.16trofastxen on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:02:08AM +0200, Pavel Machek wrote:
>> I lost you here; I've never heard of these options, nor does Google seem to.
>> Do I specify them on the kernel command line, or something else?
> echo reboot > /sys/power/disk

But we were discussing suspend-to-RAM, not suspend-to-disk, right?
Suspend-to-disk works just fine.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
