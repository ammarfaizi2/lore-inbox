Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131602AbQKZPsT>; Sun, 26 Nov 2000 10:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131997AbQKZPsK>; Sun, 26 Nov 2000 10:48:10 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:27257 "EHLO
        dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
        id <S131602AbQKZPr7>; Sun, 26 Nov 2000 10:47:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14881.10731.751006.428391@somanetworks.com>
Date: Sun, 26 Nov 2000 10:19:07 -0500 (EST)
From: "Georg Nikodym" <georgn@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <E13ztNR-0001ew-00@the-village.bc.nu>
In-Reply-To: <14880.29022.261932.284497@somanetworks.com>
        <E13ztNR-0001ew-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@home.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AC" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

 AC> Sure it generates the same code

If you accept that code == .text, as do I, then there is no code
generated for either of the forms being argued.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
