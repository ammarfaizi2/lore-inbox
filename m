Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbUDQSbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbUDQSbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:31:12 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:11156 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264009AbUDQSbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:31:11 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Sat, 17 Apr 2004 20:31:09 +0200
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sf.net>,
       <linux-kernel@vger.kernel.org>, Frederic Detienne <fd@cisco.com>
References: <Pine.LNX.4.44L0.0404141226370.1474-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0404141226370.1474-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404172031.09200.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, do you have a suggestion for how best to go from
a struct usb_interface to an index?

Thanks,

Duncan.
