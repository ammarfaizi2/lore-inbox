Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270081AbTHLL1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270093AbTHLL1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:27:39 -0400
Received: from EPRONET.01.dios.net ([65.222.230.105]:20639 "EHLO
	mail.eproinet.com") by vger.kernel.org with ESMTP id S270081AbTHLL1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:27:37 -0400
Date: Tue, 12 Aug 2003 06:54:22 -0400 (EDT)
From: "Mark W. Alexander" <slash@dotnetslash.net>
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3 problems on Acer TravelMate 260 (ALSA,ACPIvsSynaptics,yenta)
In-Reply-To: <20030812083900.GA2974@man.beta.es>
Message-ID: <Pine.LNX.4.44.0308120651520.23861-100000@llave.eproinet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Santiago Garcia Mantinan wrote:

> > existance on 2.6. Could you post or send me your PCIC=yenta config file?
> > (Debian /etc/default/pcmcia. I don't know where on other distros.)
> 
> I'm running Debian unstable here but I do not have anything special on that
> file, just the defaults changing the driver into yenta_socket, and even this
> is not necesary if you happen to have just yenta compiled.
> 
> # Defaults for pcmcia (sourced by /etc/init.d/pcmcia)
> PCMCIA=yes
> PCIC=yenta_socket
> PCIC_OPTS=
> CORE_OPTS=
> CARDMGR_OPTS=

Crap, I was afraid of that. That means my problem is probably BIOS
related.

Just in case, would you mind sending me your 2.4 config off-list?

Thanks,
mwa
-- 
Mark W. Alexander
slash@dotnetslash.net

