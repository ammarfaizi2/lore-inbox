Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129431AbQK2Aw1>; Tue, 28 Nov 2000 19:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129775AbQK2AwQ>; Tue, 28 Nov 2000 19:52:16 -0500
Received: from gl177a.Glassen.BoNet.AC ([212.217.128.37]:26129 "HELO
        findus.dhs.org") by vger.kernel.org with SMTP id <S129431AbQK2AwH>;
        Tue, 28 Nov 2000 19:52:07 -0500
Message-ID: <3A244C31.F37D420E@findus.dhs.org>
Date: Wed, 29 Nov 2000 01:22:09 +0100
From: Petter Sundlöf <odd@findus.dhs.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
In-Reply-To: <E140urK-0005FZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The K7 optimisations are not used for I/O space accessess. Or shouldnt be,
> but the nvidia code is unreadable so they may have done so

OK. I believe at least one of the NVIDIA developers read this list, so
hopefully they can look at what can be done on their side.
But seeing as how they've made no release for circa three months, and
considering the closed nature of their drivers, I doubt it'll be fixed
any time soon.

Oh well.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
