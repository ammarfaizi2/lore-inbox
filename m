Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAIONG>; Tue, 9 Jan 2001 09:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAIOMr>; Tue, 9 Jan 2001 09:12:47 -0500
Received: from herrmann.cherheim.etc.tu-bs.de ([134.169.88.65]:29708 "EHLO
	herrmann.cherheim.etc.tu-bs.de") by vger.kernel.org with ESMTP
	id <S129415AbRAIOMl>; Tue, 9 Jan 2001 09:12:41 -0500
Message-ID: <3A5B1C57.54A225DC@tu-bs.de>
Date: Tue, 09 Jan 2001 15:12:39 +0100
From: Felix Maibaum <f.maibaum@tu-bs.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nils@fht-esslingen.de
CC: linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 bug in SHM an via-rhine or is it my fault?
In-Reply-To: <Pine.LNX.4.30.0101091457330.8600-100000@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nils Philippsen wrote:

> reboot the machine or "echo 2097152 > /proc/sys/kernel/shmall".

now thats what I call a quick response, thanks, it did the trick.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
