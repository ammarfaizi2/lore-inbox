Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbTCQDTw>; Sun, 16 Mar 2003 22:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbTCQDTw>; Sun, 16 Mar 2003 22:19:52 -0500
Received: from fmr01.intel.com ([192.55.52.18]:19920 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261747AbTCQDTv>;
	Sun, 16 Mar 2003 22:19:51 -0500
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E01780DAB@orsmsx402.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: Henrik Thostrup Jensen <htj@antilogic.dk>, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Memory leak in e100
Date: Sun, 16 Mar 2003 19:30:41 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixed a memory leak in the e100 driver.
> Leak was catched by smatch.

Ack, thanks.

I'll add this to the other e100 patches I'm sending Jeff.

-scott
