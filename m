Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVINAKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVINAKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 20:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVINAKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 20:10:52 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:47751 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751199AbVINAKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 20:10:52 -0400
Date: Wed, 14 Sep 2005 02:10:26 +0200
Message-Id: <200509140010.j8E0AQml029046@localhost.localdomain>
Subject: [PATCH 0/6] isicom char driver rewritten to 2.6 api
From: Jiri Slaby <jirislaby@gmail.com>
To: akpm@osdl.org
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-reply-to: <20050913172157.GC6309@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patches convert isicom char driver to 2.6 API.

01-whitespace-cleanup
02-type-conversion-and-variables-deletion
03-others-little-changes
04-pci-probing-added
05-firmware-loading
06-more-whitespaces-and-coding-style

