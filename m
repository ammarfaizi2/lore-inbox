Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRABWtn>; Tue, 2 Jan 2001 17:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbRABWtd>; Tue, 2 Jan 2001 17:49:33 -0500
Received: from femail10.sdc1.sfba.home.com ([24.0.95.106]:5610 "EHLO
	femail10.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130235AbRABWtU>; Tue, 2 Jan 2001 17:49:20 -0500
Message-ID: <3A525573.9A61B450@flash.net>
Date: Tue, 02 Jan 2001 17:25:55 -0500
From: Rob Landley <landley@flash.net>
X-Mailer: Mozilla 4.7 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: tighter compression for x86 kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The UPX team owns all copyright in all of UPX and in each part of
> UPX.  Therefore, the UPX team may choose which license(s), and has
> chosen two
...
> This permits using UPX to pack a non-GPL executable.

Stupid question time: isn't this what the LGPL was designed to do?  The
Library GPL, so people who compiled stuff with gcc and linked it with
glibc wouldn't necessarily be gpl-ing their binary by doing so?  (Or the
leprosy GPL, or whatever Stallman's renamed it this month.  The license
text hasn't changed...)

Rob
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
