Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWHUXFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWHUXFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWHUXFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:05:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:63209 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751282AbWHUXFk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:05:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Vernon Mauery <vernux@us.ibm.com>
Subject: Re: Looking for a reliable USB network card
Date: Tue, 22 Aug 2006 01:06:03 +0200
User-Agent: KMail/1.9.1
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
References: <20060821212358.GB1558@cip.informatik.uni-erlangen.de> <200608211543.36019.vernux@us.ibm.com>
In-Reply-To: <200608211543.36019.vernux@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608220106.04192.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tuesday 22 August 2006 00:43 schrieb Vernon Mauery:
> On Monday 21 August 2006 14:23, Thomas Glanzmann wrote:
> > Hello,
> > since I have problems with my sky2 network card on my mac mini, I am
> > looking for a cheap but reliable usb network card which is available in
> > Germany. Anyone?
>
> http://www.qbik.ch/usb/devices/showdevcat.php?id=16
>
> This should give you an idea of which devices are supported.  From there,
> you should be able to find something in Germany.

Be aware of the DeLOCK adapter that is currently popular in some
retail stores. I just submitted a driver for it, but the hardware
itself seems to be relatively unreliable. When it works, you get decent
speed, but it seems to confuse the network stack and BIOS sometimes.

	Arnd <><
