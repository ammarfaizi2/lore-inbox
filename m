Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTE3KuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 06:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTE3KuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 06:50:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58328
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263571AbTE3KuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 06:50:12 -0400
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kwijibo@zianet.com
Cc: Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <3ED63BE7.8080604@zianet.com>
References: <20030529114001.GD7217@louise.pinerecords.com>
	 <1054216894.20167.76.camel@dhcp22.swansea.linux.org.uk>
	 <3ED63BE7.8080604@zianet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054289116.23561.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 11:05:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-29 at 17:57, kwijibo@zianet.com wrote:
> Well if it helps at all I can vouch for the brokeness on the
> Proliant ML530.  Granted this is not with a 2.4.21-rc kernel
> but a RedHat kernel 2.4.20-13.9smp.  Luckily I don't use IDE

That may be a different bug with drive tuning in pio mode.


