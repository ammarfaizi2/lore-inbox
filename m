Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129248AbQK2Aci>; Tue, 28 Nov 2000 19:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129267AbQK2Ac2>; Tue, 28 Nov 2000 19:32:28 -0500
Received: from gl177a.Glassen.BoNet.AC ([212.217.128.37]:23313 "HELO
        findus.dhs.org") by vger.kernel.org with SMTP id <S129248AbQK2AcX>;
        Tue, 28 Nov 2000 19:32:23 -0500
Message-ID: <3A244792.5FABBE38@findus.dhs.org>
Date: Wed, 29 Nov 2000 01:02:26 +0100
From: Petter Sundlöf <odd@findus.dhs.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to some nice people in #NVIDIA I found what seems to be a
solution; compile with processor type as "K6". No segfaults, lost
terminfo or disabled consoles.

So are there issues with the K7 processor code? Bleh, never mind, I have
no idea what I am talking about.

Original bug report: http://findus.dhs.org/~odd/nvidia.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
