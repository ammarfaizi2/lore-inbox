Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVJSKby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVJSKby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 06:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVJSKby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 06:31:54 -0400
Received: from 204.4.76.83.cust.bluewin.ch ([83.76.4.204]:38453 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S964781AbVJSKby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 06:31:54 -0400
Date: Wed, 19 Oct 2005 12:31:35 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: number of eth0 device
Message-ID: <20051019103135.GA9765@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am looking into Documentation/devices.txt in 2.4.25 and eth0 is not listed
there. If I grep "eth", I get only

38 char        Myricom PCI Myrinet board
[...]
"This device is used for status query, board control and "user level
packet I/O."  This board is also accessible as a standard networking
"eth" device.  "

and then

/dev/pethr0

Is eth0 some kind of special device that doesn't have any number
assigned?

CL<
