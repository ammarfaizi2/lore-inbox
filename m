Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129225AbQKTVu7>; Mon, 20 Nov 2000 16:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbQKTVut>; Mon, 20 Nov 2000 16:50:49 -0500
Received: from 213-123-73-80.btconnect.com ([213.123.73.80]:22022 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129626AbQKTVuk>;
	Mon, 20 Nov 2000 16:50:40 -0500
Date: Mon, 20 Nov 2000 21:22:30 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Oliver Poths <oliver.poths@linsoft.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.4.0-test11 crashed again; this time i send you the
 Oops-message 
In-Reply-To: <20001120.21034500@rock.>
Message-ID: <Pine.LNX.4.21.0011202121000.1664-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Oliver Poths wrote:
> looks fascinating...

you know, it looks even more fascinating when you pass it through ksymoops
like this:

ksymoops < rawoops > oops

and then mail the result.

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
