Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTGKTH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbTGKTEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:04:21 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:64415 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265110AbTGKTDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:03:19 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Henrique Oliveira <henrique2.gobbi@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kevin Curtis <kevin.curtis@farsite.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
References: <7C078C66B7752B438B88E11E5E20E72E25C978@GENERAL.farsite.co.uk>
	<Pine.LNX.4.55L.0307101410570.25103@freak.distro.conectiva>
	<003101c34712$a9b8f480$602fa8c0@henrique>
	<1057914760.8028.27.camel@dhcp22.swansea.linux.org.uk>
	<013901c347cd$44586f60$602fa8c0@henrique>
	<Pine.LNX.4.55L.0307111416100.29959@freak.distro.conectiva>
	<20030711172747.GK2210@gtf.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 11 Jul 2003 20:05:25 +0200
In-Reply-To: <20030711172747.GK2210@gtf.org>
Message-ID: <m3isq9djmi.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> New HDLC stuff (already in 2.5) was also developed for 2.4.  It changes
> the 2.4 HDLC userland ABI... but pretty much everybody who still
> cares about HDLC is using the new (changed) ABI.

Precisely. Still, the old HDLC is now a history, 2.4.21 contains the new
ABI/API. It's just missing some regular updates (not breaking the ABI).
-- 
Krzysztof Halasa
Network Administrator
