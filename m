Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTKPKcp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 05:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTKPKcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 05:32:45 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:63505 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262687AbTKPKco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 05:32:44 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: How to run programs off initramfs during boot?
Date: Sun, 16 Nov 2003 13:19:50 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311161319.50753.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With initramfs I can populate rootfs during boot. But I cannot see how can I 
really run anything off rootfs before real root is finally mounted.

Do I miss something or is it really not implemented currently?

TIA

-andrey

