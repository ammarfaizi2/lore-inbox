Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129436AbQKXR0m>; Fri, 24 Nov 2000 12:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129912AbQKXR0c>; Fri, 24 Nov 2000 12:26:32 -0500
Received: from blake.servalan.org ([195.40.110.2]:51729 "EHLO
        blake.servalan.org") by vger.kernel.org with ESMTP
        id <S129872AbQKXR0U>; Fri, 24 Nov 2000 12:26:20 -0500
Message-ID: <015701c05637$a5d0f9e0$2a6e28c3@servalan.org>
From: "John Thorp" <jathorp@servalan.org>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with 2.4.0test11 and PCI bridges
Date: Fri, 24 Nov 2000 16:57:36 -0000
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just tried to move to the 2.4.0-test11 kernel from the kernel
supplied with Redhat 7. With the Redhat 7 kernel I can see all the PCI slots
fine. However, when I try with the 2.4.0test11 it no longer seems to be able
to find some of the PCI buses. Is there something I can do to get the kernel
to see these PCI buses?

John

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
