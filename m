Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbQLYOHu>; Mon, 25 Dec 2000 09:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130372AbQLYOHa>; Mon, 25 Dec 2000 09:07:30 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:46852 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S129903AbQLYOHY>;
	Mon, 25 Dec 2000 09:07:24 -0500
Date: Mon, 25 Dec 2000 07:36:54 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.18 compile warnings
Message-ID: <Pine.LNX.4.30.0012250734200.977-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a large number of warnings like the following when compiling
2.2.18:

{standard input}:338: Warning: using `%eax' instead of `%ax' due to `l'
suffix

I'm using the compiler from RedHat 6.2:

Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
