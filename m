Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVJITfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVJITfF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVJITfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:35:05 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:33155 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932263AbVJITfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:35:04 -0400
Date: Sun, 9 Oct 2005 21:34:04 +0200
Message-Id: <200510091934.j99JY4w9005542@localhost.localdomain>
Subject: [PATCH 0/6] isicom char driver rewritten to 2.6 api
From: Jiri Slaby <jirislaby@gmail.com>
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patches convert isicom char driver to 2.6 API.

01-whitespace-cleanup
02-type-conversion-and-variables-deletion
03-others-little-changes
04-pci-probing-added
05-firmware-loading
06-more-whitespaces-and-coding-style
