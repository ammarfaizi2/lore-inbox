Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135627AbRAGEur>; Sat, 6 Jan 2001 23:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135681AbRAGEuh>; Sat, 6 Jan 2001 23:50:37 -0500
Received: from avocet.prod.itd.earthlink.net ([207.217.121.50]:17868 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S135627AbRAGEub>; Sat, 6 Jan 2001 23:50:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: dep <dennispowell@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Newbie]Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Date: Sat, 6 Jan 2001 23:53:40 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10101061928340.1843-100000@clueserver.org>
In-Reply-To: <Pine.LNX.4.10.10101061928340.1843-100000@clueserver.org>
MIME-Version: 1.0
Message-Id: <01010623534000.05527@depoffice.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 January 2001 10:30 pm, Alan Olsen wrote:

| AGPGART doe *not* work if compiled statically.  Compile it as a
| module. You will be much happier. (i.e. It might actually work.)  I
| would also compile DRM and the r128 drivers as modules as well.

it's worked fine compiled into the kernel here, along with the dri 
and mga stuff since test4.

-- 
dep
--
bipartisanship: an illogical construct not unlike the idea that
if half the people like red and half the people like blue, the 
country's favorite color is purple.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
