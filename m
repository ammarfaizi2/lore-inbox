Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129538AbQKXTqh>; Fri, 24 Nov 2000 14:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129835AbQKXTq1>; Fri, 24 Nov 2000 14:46:27 -0500
Received: from quechua.inka.de ([212.227.14.2]:33624 "EHLO mail.inka.de")
        by vger.kernel.org with ESMTP id <S129538AbQKXTqP>;
        Fri, 24 Nov 2000 14:46:15 -0500
To: linux-kernel@vger.kernel.org
Subject: [Oops] apic, smp and k6
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <20001124181723.BAAC7B7813@dungeon.inka.de>
Date: Fri, 24 Nov 2000 19:17:23 +0100 (CET)
From: aj@dungeon.inka.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a dual board (meant for pentium) with one k6 200 and
a 2.4.0-test11 kernel with APIC support enabled does
oops here. removed the APIC support, and now everything is fine.
i read here it´s a known problem ? at least someone
else reported this, and it´s the same problem here.

regards, andreas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
