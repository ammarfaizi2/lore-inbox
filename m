Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130108AbQKYUcL>; Sat, 25 Nov 2000 15:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131730AbQKYUcB>; Sat, 25 Nov 2000 15:32:01 -0500
Received: from hera.cwi.nl ([192.16.191.1]:60400 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S130108AbQKYUby>;
        Sat, 25 Nov 2000 15:31:54 -0500
Date: Sat, 25 Nov 2000 21:01:47 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
Message-ID: <20001125210147.A6798@veritas.com>
In-Reply-To: <14878.58.908955.701821@notabene.cse.unsw.edu.au> <Pine.LNX.4.21.0011251522430.8818-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011251522430.8818-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Nov 25, 2000 at 03:26:15PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 03:26:15PM -0200, Rik van Riel wrote:

> The gcc-2.95.2-6cl from Conectiva 6.0 is buggy too.

Yes. Probably you have seen it by now, but the difference between
good and bad versions of gcc-2.95.2 did not lie in the applied patches,
but was the difference between compilation for 686 or 386.
It is not your (SuSE's, Debian's) fault. A fix already exists.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
