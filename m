Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVIMQto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVIMQto (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVIMQtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:49:43 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:20097 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S964878AbVIMQtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:49:43 -0400
Date: Tue, 13 Sep 2005 18:49:23 +0200
Message-Id: <200509131649.j8DGnNnw021871@localhost.localdomain>
Subject: [PATCH 0/5] isicom char driver to 2.6 api
From: Jiri Slaby <jirislaby@gmail.com>
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
In-reply-to: <20050912045834.GA18780@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patches convert isicom char driver to 2.6 API.

1 - whispace cleanup
2 - types changes
3 - pci probing
4 - firmware loading
5 - more whitespace cleanup + wrapping lines
