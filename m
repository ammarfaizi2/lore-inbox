Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTDRI6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 04:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbTDRI6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 04:58:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37127 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262987AbTDRI6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 04:58:51 -0400
Date: Fri, 18 Apr 2003 10:10:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Patrick Mochel <mochel@osdl.org>,
       Grover Andrew <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
Message-ID: <20030418101042.B25177@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Patrick Mochel <mochel@osdl.org>,
	Grover Andrew <andrew.grover@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030417150926.GA25402@gtf.org> <200304171547.h3HFljoK000140@81-2-122-30.bradfords.org.uk> <20030418073754.GA2753@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030418073754.GA2753@kroah.com>; from greg@kroah.com on Fri, Apr 18, 2003 at 12:37:54AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 12:37:54AM -0700, Greg KH wrote:
> PCI Hotplug does not support video cards for just this reason.

/me points at the Mobility Electronics EV1000 Cardbus-PCI widget
with a ATI Rage VGA device.  Ok, it's hot-pluggable, but it'd be
nice to work out a way to support it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

