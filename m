Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTEaJIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 05:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTEaJIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 05:08:53 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:45261 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264246AbTEaJIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 05:08:51 -0400
Date: Sat, 31 May 2003 11:21:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: [PATCH for testing] 1/2 central workspace for zlib, for 2.5.70
Message-ID: <20030531092143.GA19898@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very stupid port from the 2.4 code.  Quite enough for 99.9%
of all users, but the final one should register callbacks for cpus
being added and removed.

Patch 2/2 applies to both 2.4.20 and 2.5.70, so I won't resend.

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
