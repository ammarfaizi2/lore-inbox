Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTETWga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTETWga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:36:30 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:61713 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261292AbTETWga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:36:30 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 00/14] USB speedtouch update
Date: Wed, 21 May 2003 00:49:24 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210049.24619.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches are against Greg's 2.5 USB tree.
They contain a rewrite of the packet reception code and
many tweaks.

Duncan.
