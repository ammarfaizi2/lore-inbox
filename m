Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129507AbQK2JX3>; Wed, 29 Nov 2000 04:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130529AbQK2JXT>; Wed, 29 Nov 2000 04:23:19 -0500
Received: from 62-6-231-191.btconnect.com ([62.6.231.191]:39172 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129745AbQK2JXN>;
        Wed, 29 Nov 2000 04:23:13 -0500
Date: Wed, 29 Nov 2000 08:54:44 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <3A2437F6.6380A1BF@haque.net>
Message-ID: <Pine.LNX.4.21.0011290853410.1129-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad, 

can you please tell me if that 4K corrupted block in a file was on a UP
machine or SMP? So far I have not seen a corruption on UP machines, only
SMP.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
