Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276917AbRJQO7L>; Wed, 17 Oct 2001 10:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276914AbRJQO7B>; Wed, 17 Oct 2001 10:59:01 -0400
Received: from atlas.inria.fr ([138.96.66.22]:38412 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S276917AbRJQO6w>;
	Wed, 17 Oct 2001 10:58:52 -0400
Message-Id: <200110171459.f9HExLJ01069@atlas.inria.fr>
Content-Type: text/plain; charset=US-ASCII
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
To: linux-kernel@vger.kernel.org
Subject: How to disable disk cache with kernel 2.4.2 ?
Date: Wed, 17 Oct 2001 16:59:21 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
i try to disable the disk cache in kernel 2.4.2 with :
echo "0 0 0" > /proc/sys/vm/pagecache
or
echo "0 0 0" > /proc/sys/vm/buffermem
without any success.

Where can i find documentation about the disk cache ?

N. Turro
PS: i'd like to turn-off the disk cache for disk benchmarks.

 
