Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272394AbTGYXvk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272393AbTGYXvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:51:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50560
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S272395AbTGYXvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:51:36 -0400
Subject: Re: 2.4 -> 2.2 differences?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernd Eckenfels <ecki-lkm@lina.inka.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E19gC0Z-0001RR-00@calista.inka.de>
References: <E19gC0Z-0001RR-00@calista.inka.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059177773.1204.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jul 2003 01:02:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-26 at 00:29, Bernd Eckenfels wrote:
> In article <20030725142434.GS32585@rdlg.net> you wrote:
> > With all the SCO fun going on I have people asking me what functionality
> > we would loose if we rolled from 2.4.21 kernel to the last known stable
> > 2.2 kernel.
> 
> it is easier to turn off SMP.
> 
> BTW: what will happen if there is some SMP code from IBM in the kernel which
> is owned by SCO? Isnt it a matter of days to remove that code? Does anybody
> have to pay for past usage of the code?

The core 2.2 SMP code is stuff I wrote. Caldera (aka SCO) even provided
me the hardware and asked me to do it. The later table parser code is
from Intel.


