Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316264AbSEVRUb>; Wed, 22 May 2002 13:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316265AbSEVRUa>; Wed, 22 May 2002 13:20:30 -0400
Received: from attila.stevens-tech.edu ([155.246.14.11]:14635 "EHLO
	attila.stevens-tech.edu") by vger.kernel.org with ESMTP
	id <S316264AbSEVRU3>; Wed, 22 May 2002 13:20:29 -0400
Date: Wed, 22 May 2002 13:20:28 -0400
From: Hayden James <hjames@stevens-tech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: nVidia NIC/IDE/something support?
Message-ID: <Pine.SGI.4.30.0205221316500.3534318-100000@attila.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The asus board uses the realtek 8139 as the onboard nic and should be
supported by the linux kernel.  The audio seems to be an exact clone of
the i810 driver with just same name changes and added pci ids, you can
get the gpl patches for it at nvidia's web site.  The rest of the
facilities, ide, usb etc should be supported normally by the linux kernel.
Also you will need to get the separate nVidia video driver for graphics
support.

Hayden A. James
Computer Engineering
Stevens Institute of Technology
http://attila.stevens-tech.edu/~hjames/

