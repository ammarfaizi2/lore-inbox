Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbSLIN2t>; Mon, 9 Dec 2002 08:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbSLIN2t>; Mon, 9 Dec 2002 08:28:49 -0500
Received: from [81.2.122.30] ([81.2.122.30]:54020 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265506AbSLIN2s>;
	Mon, 9 Dec 2002 08:28:48 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212091346.gB9DkcgN000690@darkstar.example.net>
Subject: Re: BUG in 2.5.50
To: acme@conectiva.com.br (Arnaldo Carvalho de Melo)
Date: Mon, 9 Dec 2002 13:46:38 +0000 (GMT)
Cc: roy@karlsbakk.net, zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       alan@redhat.com
In-Reply-To: <20021209132712.GK17067@conectiva.com.br> from "Arnaldo Carvalho de Melo" at Dec 09, 2002 11:27:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Its a development kernel... Alan keeps stating that one should not
> enable TCQ, so even with this being available in make menuconfig,
> please try without it.

Is IDE TCQ liable to corrupt data on read-only volumes or just
read-write?  The problem with nobody using it, is that it never gets
tested - if there are no known issues with read-only use it would be
nice to know.

John.
