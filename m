Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUBURU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 12:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUBURU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 12:20:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:5071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261584AbUBURU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 12:20:28 -0500
X-Authenticated: #4512188
Message-ID: <4037934E.2000306@gmx.de>
Date: Sat, 21 Feb 2004 18:20:14 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 018 release
References: <20040219185932.GA10527@kroah.com>
In-Reply-To: <20040219185932.GA10527@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

could it be that udev 018 deosn't compile against 2.6.3 kernel headers? 
I am not sure if this is the case or if the gentoo ebuild or archive has 
some trouble:
In Datei, eingefügt von 
/var/tmp/portage/udev-018/work/udev-018/libsysfs/sysfs_bus.c:23:
/var/tmp/portage/udev-018/work/udev-018/libsysfs/sysfs/libsysfs.h:27:19: 
dlist.h: Datei oder Verzeichnis nicht gefunden
/

And then a hunk of errors. (Above states that libsysfs.h cannot find 
dlist.h.)

bye,

Prakash
