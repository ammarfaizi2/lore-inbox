Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUBSTgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267504AbUBSTgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:36:14 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:44551 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267497AbUBSTgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:36:11 -0500
Date: Thu, 19 Feb 2004 19:36:07 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: linux-hotplug-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: HOWTO use udev to manage /dev
In-Reply-To: <20040219191636.GC10527@kroah.com>
Message-ID: <Pine.LNX.4.44.0402191933350.26894-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a question for you. Presently both the serial ttys and VT ttys 
share the same major number. Minor number 1 to 63 is allocated to the VTs 
and 64 and above to serial ttys. One of the great limitations for my home 
system is that I can have only 63 VTs. Can udev work around this 
limitation?


