Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbSJUSLJ>; Mon, 21 Oct 2002 14:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261304AbSJUSLJ>; Mon, 21 Oct 2002 14:11:09 -0400
Received: from ns.ithnet.com ([217.64.64.10]:1033 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261191AbSJUSKy>;
	Mon, 21 Oct 2002 14:10:54 -0400
Date: Mon, 21 Oct 2002 20:16:44 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: laforge@gnumonks.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: 2.4.20-pre7: ip_conntrack: table full, dropping packet.
Message-Id: <20021021201644.166db824.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

After several days running kernel 2.4.20-pre7 I came across the syslogged
message:

kernel: ip_conntrack: table full, dropping packet.

This box runs about 10 rules for destination nat. My simple question: is this a
bug, or a need to tune something? If it is a bug, is there a later kernel that
has it fixed?
-- 
Regards,
Stephan
