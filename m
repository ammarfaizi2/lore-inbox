Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVGHI4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVGHI4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVGHIz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:55:59 -0400
Received: from buffy.riseup.net ([69.90.134.155]:31108 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S262379AbVGHIzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:55:50 -0400
Date: Fri, 8 Jul 2005 10:58:40 +0200
From: st3@riseup.net
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
Subject: Re: speedstep-centrino on dothan
Message-ID: <20050708105840.784f6d53@horst.morte.male>
In-Reply-To: <20050708051050.GA3201@isilmar.linta.de>
References: <20050706112202.33d63d4d@horst.morte.male>
	<42CC37FD.5040708@tmr.com>
	<20050707235928.71016f61@horst.morte.male>
	<20050708051050.GA3201@isilmar.linta.de>
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005 07:10:50 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> On Thu, Jul 07, 2005 at 11:59:28PM +0200, st3@riseup.net wrote:
> > read from ACPI tables, while still keeping them available.
> 
> You're only keeping some of them available, as you overwrite one such
> setting. Alternatively you can increase p.state_count by one early enough.

Yes, but I was just overwriting the latest ones, that are never used =).
Anyway, your solution is theoretically better.


--
ciao
st3

