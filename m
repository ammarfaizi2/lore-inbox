Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268648AbUJKCKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268648AbUJKCKE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 22:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268646AbUJKCKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 22:10:04 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:23441 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S268648AbUJKCKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 22:10:00 -0400
From: Ampoulin <ampoulin@altern.org>
To: linux-kernel@vger.kernel.org
Subject: IT8212 IDE driver on ASUS P5GD-VM (IT8211)
Date: Mon, 11 Oct 2004 04:09:56 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410110409.56544.ampoulin@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is the patch provided by Alan Cox for IT8212 on linux 2.6.9-rc3 supposed to 
work on IT8211 ? I tried it and it wasn't working.

Both chips seem to be very close (but 8211 has'nt raid support), and they even 
share the same driver availabled on ite website 
(http://www.iteusa.com/pc/LinuxDriverSrc_it8212_092005-09.zip).

Regards, Julien
