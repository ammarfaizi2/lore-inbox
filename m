Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbRARVrK>; Thu, 18 Jan 2001 16:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131482AbRARVrA>; Thu, 18 Jan 2001 16:47:00 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:3909 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130870AbRARVq7>; Thu, 18 Jan 2001 16:46:59 -0500
Message-ID: <3A676440.E5300256@linux.com>
Date: Thu, 18 Jan 2001 21:46:40 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Crawford <billc@netcomuk.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with networking in 2.4.0
In-Reply-To: <3A6760E8.C7023346@netcomuk.co.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Crawford wrote:

>  In connection with connection failures using recent kernels, it often
> seems to be related to ECN being enabled.
>
>  PIX firewalls seem to interpret the ECN option header as a source
> route header (that's what it's logged as).
>
>  I got bitten by this at work ;·(

Cisco is aware of the ECN issues and has updates for their stuff.

-d

--
..NOTICE fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
