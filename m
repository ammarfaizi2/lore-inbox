Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSIOGer>; Sun, 15 Sep 2002 02:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317865AbSIOGeq>; Sun, 15 Sep 2002 02:34:46 -0400
Received: from mail.uklinux.net ([80.84.72.21]:13061 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S317862AbSIOGeq>;
	Sun, 15 Sep 2002 02:34:46 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
From: Mark Hindley <mark@hindley.uklinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15748.10939.882581.867430@titan.home.hindley.uklinux.net>
Date: Sun, 15 Sep 2002 07:37:47 +0100 (BST)
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.19
In-Reply-To: <20020914235316.A768@titan.home.hindley.uklinux.net>
References: <20020914235316.A768@titan.home.hindley.uklinux.net>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further to my oops report, just had another. The only thing in the
logs is

Sep 15 02:40:25 titan kernel: kernel BUG at page_alloc.c:206!

Don't know if that is any help.

Mark
