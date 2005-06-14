Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVFNSDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVFNSDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVFNSDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:03:16 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:57788 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261274AbVFNSDM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:03:12 -0400
Date: Tue, 14 Jun 2005 20:03:10 +0200
From: Florian Engelhardt <flo@dotbox.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AHCI chipset for AMD64
Message-ID: <20050614200310.143359bc@discovery.hal.lan>
In-Reply-To: <42AF014A.5000104@pobox.com>
References: <1118750451.42aec6f325fc8@www.domainfactory-webmail.de>
	<42AF014A.5000104@pobox.com>
X-Mailer: Sylpheed-Claws 1.9.11cvs57 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2005 12:09:46 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Florian Engelhardt wrote:
> > Hello,
> > 
> > is there right now a mainboard on the market,
> > which has an ahci capable sata-controller
> > for an amd64 CPU?
> > It looks to me like the only chip that is a ahci
> > chip is the via vt8251, but i couldn__t find
> > a mainboard for amd64 cpu__s with that chip.
> 
> Specifically AMD64?
> 
> The current Intel EM64T computers ship with AHCI.

Sorry, but i forgot to ask one technical question about AHCI.
Will every AHCI capable controller be supported, for example
this chipset:
http://www.vitalitycomputer.com/msirsamd64so.html

-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination
