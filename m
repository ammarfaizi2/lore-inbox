Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbUKHFZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUKHFZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 00:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbUKHFZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 00:25:51 -0500
Received: from services110.cs.uwaterloo.ca ([129.97.152.166]:46477 "EHLO
	services110.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261819AbUKHFZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 00:25:47 -0500
Date: Mon, 8 Nov 2004 00:25:44 -0500 (EST)
From: Suihong Liang <s2liang@cs.uwaterloo.ca>
X-X-Sender: s2liang@hopper.math.uwaterloo.ca
To: linux-kernel@vger.kernel.org
Subject: acquireing IP address via DHCP
Message-ID: <Pine.GSO.4.58.0411072331590.10082@hopper.math.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Miltered: at rhadamanthus by Joe's j-chkmail ("http://j-chkmail.ensmp.fr")!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question about WLAN: how does Linux recognize that it has entered
a 802.11 network? and how does it acquire an IP address via DHCP
automatically?

I've successfully configured the DHCP server and the mobile host to work
together. However I want to know the detailed procesures carried out, such
as how scan/authentication/association is triggered, how dhclient is
triggered?

My machine is a RH9 with kernel 2.4.26 or 2.6.7 (wireless extensions
used), and the wireless adapter is Linksys WUSB11 v2.8 (driver from
http://at76c503a.berlios.de/).

Any information'd be appreciated.
suihong
