Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbSL3GdR>; Mon, 30 Dec 2002 01:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSL3GdR>; Mon, 30 Dec 2002 01:33:17 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:50858 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266755AbSL3GdP>;
	Mon, 30 Dec 2002 01:33:15 -0500
Date: Mon, 30 Dec 2002 17:41:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs
 5/7 S390X
Message-Id: <20021230174127.1cbb1f4c.sfr@canb.auug.org.au>
In-Reply-To: <20021230173854.3374eb1f.sfr@canb.auug.org.au>
References: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
	<20021230173854.3374eb1f.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of course, I forgot to change the Subject on the S390X patch
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
