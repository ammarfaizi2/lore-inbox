Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTJaMbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTJaMbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:31:22 -0500
Received: from netmaster.tvnetwork.hu ([80.95.68.223]:54401 "EHLO
	netmaster.tvnetwork.hu") by vger.kernel.org with ESMTP
	id S263262AbTJaMbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:31:20 -0500
Date: Fri, 31 Oct 2003 13:31:07 +0100 (CET)
From: Kiss Karoly <karcsi@tvnetwork.hu>
To: sales@repotec.com
cc: gnu@gnu.org, linux-kernel@vger.kernel.org,
       linux-wlan-user@lists.linux-wlan.com
Subject: Linux driver question.
Message-ID: <Pine.LNX.4.55.0310311208410.1798@netmaster.tvnetwork.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Your company has released a driver for the RP-242201 22Mbps Wireless
LAN card to use with the Linux operating system.
The driver is provided in a binary form called acx100_pci.o and some
additional documentation and minimal utilities also in a binary form.
The driver information contains the following:

root:/usr/src/acx_orig/RP-241101(2411AP)/Linux# modinfo acx100_pci.o
filename:    acx100_pci.o
description: "TI ACX100 WLAN 22Mbps driver"
author:      "Lancelot Wang"
license:     "GPL"

I also noticed that the utilities look very similar to those contained in
the linux-wlan-ng driver package which is licensed under the Mozilla
Public License.

As I understand the GNU General Public License, this driver was released
under, states in section 3, quote:

3. You may copy and distribute the Program (or a work based on it, under
Section 2) in object code or executable form under the terms of Sections 1
and 2 above provided that you also do one of the following:
a) Accompany it with the complete corresponding machine-readable source
code, which must be distributed under the terms of Sections 1 and 2 above
on a medium customarily used for software interchange; or,

b) Accompany it with a written offer, valid for at least three years, to
give any third party, for a charge no more than your cost of physically
performing source distribution, a complete machine-readable copy of the
corresponding source code, to be distributed under the terms of Sections 1
and 2 above on a medium customarily used for software interchange; or,

c) Accompany it with the information you received as to the offer to
distribute corresponding source code. (This alternative is allowed only
for noncommercial distribution and only if you received the program in
object code or executable form with such an offer, in accord with
Subsection b above.)

The entire license text can be found at:

http://www.gnu.org/copyleft/gpl.html

I found no source code or any documentation about the location from where
I can download it or any contact address from where I can get a copy of
it.

Please provide the necessary information, for receiving a copy of this
driver in source code.

Best regards,

Kiss Karoly
