Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTICMx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbTICMx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:53:59 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:32445 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262013AbTICMx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:53:58 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 3 Sep 2003 14:53:56 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: adq_dvb@lidskialf.net, rl@hellgate.ch, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Where do I send APIC victims?
Message-Id: <20030903145356.35b9a192.skraw@ithnet.com>
In-Reply-To: <1062589205.19059.6.camel@dhcp23.swansea.linux.org.uk>
References: <20030903080852.GA27649@k3.hellgate.ch>
	<200309031123.58713.adq_dvb@lidskialf.net>
	<20030903093808.GA28594@k3.hellgate.ch>
	<200309031148.03941.adq_dvb@lidskialf.net>
	<1062589205.19059.6.camel@dhcp23.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 12:40:06 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2003-09-03 at 11:48, Andrew de Quincey wrote:
> > 2.4.22 has the ACPI from 2.6 backported into it, (which includes my patch
> > for nforce2 boards) so it will start having the same issue with the BIOS
> > bug in KT333/KT400  boards.
> 
> It does - 2.4.22pre7 is great on my boxes, 2.4.22 final ACPI is
> basically unusable on anything I own thats not intel. 

I can't back that. At least on all my Serverworks boxes there are no problems
with ACPI. I got reports from VIA-bases SMP boards that they are doing well, too.
(all for 2.4.22)

Regards,
Stephan
