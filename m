Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129684AbQK0Xjl>; Mon, 27 Nov 2000 18:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129931AbQK0XjR>; Mon, 27 Nov 2000 18:39:17 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:36612 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S129639AbQK0XjJ>; Mon, 27 Nov 2000 18:39:09 -0500
Message-ID: <3A22E894.4E15E71@timpanogas.org>
Date: Mon, 27 Nov 2000 16:04:52 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.18-23 w/Frame Buffer (LEVEL IV)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A level IV issue in 2.2.18-23.  With frame buffer enabled, upon boot,
the OS is displaying four penguin images instead of one penguin in the
upper left corner of the screen.  Looks rather tacky.  Also puts the VGA
text mode default into mode 274.   Is this what's supposed to happen?

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
