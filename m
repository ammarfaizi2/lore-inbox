Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTICILZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbTICIK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:10:28 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:47263 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S261548AbTICIJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:09:34 -0400
Date: Wed, 3 Sep 2003 10:08:52 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: Where do I send APIC victims?
Message-ID: <20030903080852.GA27649@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	acpi-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test4 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the maintainer of via-rhine, I get bug reports that almost in their
entirety are "fixed" by turning off APIC and/or ACPI. This has been going
on for several months now. Every now and then, something promising gets
posted on LKML, but so far if anything I've seen an _increase_ in those bug
reports. Maybe a fix is floating around and this will be a non-issue RSN. I
simply can't tell, since I don't have any IO-APIC hardware to play with.

Instead of just telling everybody to turn off APIC, I'd like to point bug
reporters to the proper place and tell them what information they should
provide so it can get fixed for real. According to MAINTAINERS, Ingo Molnar
does Intel APIC, but the problems are with VIA chip sets. So where do I
send my users? Any takers?

Roger
