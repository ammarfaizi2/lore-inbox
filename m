Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268557AbTGNSwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270709AbTGNSwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:52:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39044 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268557AbTGNSwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:52:21 -0400
Message-ID: <3F12FF53.7060708@pobox.com>
Date: Mon, 14 Jul 2003 15:06:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpms
 installed)
References: <1058196612.3353.2.camel@aurora.localdomain>
In-Reply-To: <1058196612.3353.2.camel@aurora.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trever L. Adams wrote:
> OK, I now get past the initialization of the 3c920.  However, now it
> hangs (sak enabled, sak doesn't work... completely dead) when eth0 tries
> to come up.  I have IPv6 enabled (the router does 6to4, this isn't the
> router), I don't believe I have any firewall stuff on this box, it does
> dhcp for IPv4 address and ntp time.


hmmm... do you have the latest modutils installed?

