Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130172AbRBMND2>; Tue, 13 Feb 2001 08:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbRBMNDS>; Tue, 13 Feb 2001 08:03:18 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130172AbRBMNDO>; Tue, 13 Feb 2001 08:03:14 -0500
Subject: Re: Linux 2.2.19pre10
To: cr@sap.com (Christoph Rohland)
Date: Tue, 13 Feb 2001 13:03:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        cowboy@vnet.ibm.com (Richard A Nelson), linux-kernel@vger.kernel.org
In-Reply-To: <m3ofw7m240.fsf@linux.local> from "Christoph Rohland" at Feb 13, 2001 01:23:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Sf7T-0001ia-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Possibly but its a minor item that doesnt really matter anyway so leaving it
> > is fine
> 
> No, I do not think that it's minor. We had to bring down running
> application servers to be able to start another one, because the new
> one couldn't create or attach the systemwide os-monitoring
> segment and thus refused to start. That's very bad behaviour.

Well I'll take corrected fixes, but Im not going to hold up a release for it
