Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUHGADa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUHGADa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 20:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268253AbUHGADa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 20:03:30 -0400
Received: from web81706.mail.yahoo.com ([206.190.37.137]:50551 "HELO
	web81706.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268148AbUHGADV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 20:03:21 -0400
Message-ID: <20040807000316.85612.qmail@web81706.mail.yahoo.com>
Date: Fri, 6 Aug 2004 17:03:16 -0700 (PDT)
From: Josh Radel <jraidman-linux@yahoo.com>
Reply-To: jraidman-linux@yahoo.com
Subject: elevator abstraction, anticipatory I/O backported to 2.4?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any existing patches for a backport of the
2.6 elevator abstraction (or a specific patch for
anticipatory I/O) to 2.4 kernels?

I've heard rumors that Digeo backported a 2.6 I/O
scheduler. However, when I tried to download their
open source modifications from
http://www.digeo.com/prodserv/opensource.jsp, I wasn't
able to extract their work. (The zip file unzips to a
tar.bz2, which seems to be corrupt.) Who knows, maybe
an I/O scheduler backport isn't in that archive
anyway.

Please CC me on any response.

Thanks,
Josh
