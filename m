Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275292AbTHMSVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275296AbTHMSV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:21:29 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:47622 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S275292AbTHMSV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:21:29 -0400
Date: Wed, 13 Aug 2003 20:21:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813182125.GA13130@mars.ravnborg.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, rddunlap@osdl.org, davej@redhat.com,
	willy@debian.org, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <20030813175009.GA12128@mars.ravnborg.org> <20030813175810.GB3317@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813175810.GB3317@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 10:58:10AM -0700, Greg KH wrote:
> 
> No, you want to be able to add a ".driver_data = foo" after a
> PCI_DEVICE() macro.  If you have the {} there, that prevents that from
> happening.

Obvious, thanks for the explanation.

	Sam
