Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129823AbQK1Qlr>; Tue, 28 Nov 2000 11:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129800AbQK1Qlh>; Tue, 28 Nov 2000 11:41:37 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:269 "EHLO virtualro.ic.ro")
        by vger.kernel.org with ESMTP id <S129728AbQK1Qla>;
        Tue, 28 Nov 2000 11:41:30 -0500
Date: Tue, 28 Nov 2000 18:10:44 +0200 (EET)
From: <jani@virtualro.ic.ro>
To: linux-kernel@vger.kernel.org
Subject: binfmt question
Message-ID: <Pine.LNX.4.10.10011281807140.7206-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Is every process supposed to have a valid  binary format?
(binfmt field !=NULL in it's task_struct).I hope so.

Thanks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
