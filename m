Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290185AbSBFHkU>; Wed, 6 Feb 2002 02:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290223AbSBFHkL>; Wed, 6 Feb 2002 02:40:11 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:29646 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290185AbSBFHkB>; Wed, 6 Feb 2002 02:40:01 -0500
Date: Wed, 6 Feb 2002 09:33:18 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <Pine.LNX.4.33.0202050959020.25114-100000@segfault.osdlab.org>
Message-ID: <Pine.LNX.4.44.0202060930130.8308-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Patrick Mochel wrote:

> I think that ide should get its own bus, as a child of the ide controller. 
> I haven't looked at ide yet at all. But, on most modern systems, the ide 
> controller is a function of the southbridge, so ide devices should go 
> under that. Like what the usb stuff does now...

How about add-on ATA controllers? 

Cheers,
	Zwane Mwaikambo


