Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275045AbRJFGzG>; Sat, 6 Oct 2001 02:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275067AbRJFGy4>; Sat, 6 Oct 2001 02:54:56 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:4912 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S275045AbRJFGyt> convert rfc822-to-8bit; Sat, 6 Oct 2001 02:54:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: OOM-Killer in 2.4.11pre4
Date: Sat, 6 Oct 2001 08:53:30 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15plMj-0002eK-00@mrvdom01.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported __alloc_pages: 0-order allocation failed errors in 2.4.10 with a 
memory eating program. 

These errors are gone with 2.4.11pre4. The OOM-Killer works __correct__.  it 
seems that Marcelos Patch works correct for me.


