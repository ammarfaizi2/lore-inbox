Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRGDMjG>; Wed, 4 Jul 2001 08:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264451AbRGDMi4>; Wed, 4 Jul 2001 08:38:56 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:53011 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264375AbRGDMit>; Wed, 4 Jul 2001 08:38:49 -0400
Date: Wed, 4 Jul 2001 13:38:48 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically
Message-ID: <20010704133848.G5254@redhat.com>
In-Reply-To: <20010704133634.F5254@redhat.com> <E15Hlv3-0000qs-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15Hlv3-0000qs-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jul 04, 2001 at 01:38:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2001 at 01:38:13PM +0100, Alan Cox wrote:

> Can hotplug handle this from a PCI id table ?

There is a PCI id table in parport_serial, yes (if that's what you're
asking).

Tim.
*/
