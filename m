Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTEWG51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEWG51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:57:27 -0400
Received: from hera.cwi.nl ([192.16.191.8]:62909 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263759AbTEWG50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:57:26 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 23 May 2003 09:10:31 +0200 (MEST)
Message-Id: <UTC200305230710.h4N7AVo25664.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69bk15 usb problem solved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just said this on usb-devel but maybe I should have cc'd l-k:

usb in 2.5.69bk14 works, in 2.5.69bk15 fails, as both Adam an I
observed. I find that backing out the usb/core/message.c patch
fixes things again.

Andries
