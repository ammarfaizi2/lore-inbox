Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWIDWxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWIDWxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWIDWxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:53:08 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:36584 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932222AbWIDWxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:53:04 -0400
Date: Tue, 5 Sep 2006 00:53:03 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: x60 - spontaneous thermal shutdown
Message-ID: <20060904225303.GB1614@rhlx01.fht-esslingen.de>
References: <20060904214059.GA1702@elf.ucw.cz> <20060904222614.GA1614@rhlx01.fht-esslingen.de> <20060904223520.GB1958@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060904223520.GB1958@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 05, 2006 at 12:35:20AM +0200, Pavel Machek wrote:
> Well, but those macbooks were really overheating, no? This seems like
> sensor failure, because I do not think cpu had 128 Celsius, without
> going through 100 Celsius, first.

No, in several cases it was a problem with a broken/damaged sensor cable.
But it seems there are a number of different problems with thermal
management, a non-working sensor cable only being (albeit a significant)
one of those.
Google "MacBook random shutdown" will provide tons of information.

> I had fan working at the time of shutdown, and machine was able to
> boot immediately afterwards. That means that 128 celsius was sensor
> error.

Let's hope people get that braindamage resolved, either via BIOS updates
(hmm, but probably not helpful in case of ACPI?) or by shipping/repairing
into working hardware (an astonishing amount of people already had their
2nd or 3rd non-working repair).

Andreas Mohr
