Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTKBKbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 05:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbTKBKbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 05:31:14 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:12562 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261626AbTKBKbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 05:31:12 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6 - does usermodehelper close all fd's before executing?
Date: Sun, 2 Nov 2003 13:21:01 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311021321.01573.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4 exec_usermodehelper explicitly closed all fd's. In 2.6 this piece of 
code no more exists and I am not sure if fd's are still closed.

Any hints appreciated.

TIA

-andrey

