Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTDGLVv (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTDGLVv (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:21:51 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:6091 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S263383AbTDGLVu (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 07:21:50 -0400
Date: Mon, 7 Apr 2003 13:33:20 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: ext3 features/options
Message-ID: <Pine.LNX.4.51.0304071323240.15910@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

how do i see which features / options filesystem has set ?
i think tune2fs can only set or clear the flags.

I am asking of this because i set some features on ext3, and i want
to resize the fs using ext2resize (I have read it is okay to do that)
and ext2resize says i have incomptible features set. And it is not
about the journaling, because i have been resizing journaled fs earlier
on.

Regards,
Maciej

