Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTDGMK4 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTDGMK4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:10:56 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:17166 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id S263394AbTDGMKj (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 08:10:39 -0400
To: linux-kernel@vger.kernel.org
Subject: depmod fails if kernel linked with ld 2.13
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 07 Apr 2003 14:22:13 +0200
Message-ID: <yw1xfzoujy4q.fsf@nogger.e.kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the kernel is linked with ld from GNU binutils 2.13 depmod
complains about lots of unresolved symbols.  Isn't it about time that
this was fixed?

-- 
Måns Rullgård
mru@users.sf.net
