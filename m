Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTDQO33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTDQO33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:29:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42694
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261493AbTDQO32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:29:28 -0400
Subject: RE: firmware separation filesystem (fwfs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Riley Williams <rhw@MemAlpha.fslife.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BKEGKPICNAKILKJKMHCAKEDNCHAA.rhw@MemAlpha.fslife.co.uk>
References: <BKEGKPICNAKILKJKMHCAKEDNCHAA.rhw@MemAlpha.fslife.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050586990.31390.46.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 14:43:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 17:57, Riley Williams wrote:
> I know that PCI uses a 32-bit number (or two 16-bit numbers if one
> prefers to think of it that way) to identify each piece of equipment.
> Is there a similar number for USB, Firewire, etc?

Yes but these often don't tell you the firmware you need. The firmware
querying is often rather more device specific .

