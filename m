Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130480AbQLEWIQ>; Tue, 5 Dec 2000 17:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130634AbQLEWIF>; Tue, 5 Dec 2000 17:08:05 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:18699 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130480AbQLEWH5>; Tue, 5 Dec 2000 17:07:57 -0500
Message-ID: <3A2D6016.E97675B4@Hell.WH8.TU-Dresden.De>
Date: Tue, 05 Dec 2000 22:37:26 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <Pine.LNX.4.21.0012051104510.7727-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> Do you know if only one specific chip revision exhibits this problem? It
> would really help track down the problem. If I remember correctly, 82557
> doesn't have flow control at all, and 82558/9 have different
> implementations -- one is proprietary (82558) and one is standard (82559).

82559 has this problem for sure.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
