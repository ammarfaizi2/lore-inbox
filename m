Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423029AbWBBGwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423029AbWBBGwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423039AbWBBGwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:52:00 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:22765 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1423029AbWBBGv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:51:59 -0500
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
From: Arjan van de Ven <arjan@infradead.org>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jiri Slaby <xslaby@fi.muni.cz>,
       kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <1138810616.16643.30.camel@tara.firmix.at>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
	 <Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr>
	 <1138810616.16643.30.camel@tara.firmix.at>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 07:51:47 +0100
Message-Id: <1138863107.3270.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 17:16 +0100, Bernd Petrovitsch wrote:
> On Wed, 2006-02-01 at 17:14 +0100, Jan Engelhardt wrote:
> [...]
> > >change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...
> > >
> > is there a kernel patch that does allow it?
> 
> Yes, in RedHat's/Fedora's kernels since ages.

wrong.
there is NO kernel patch for this. Not in RHs and not in Fedora's
kernel.
Never was either.
it's 100% done in the initrd.


