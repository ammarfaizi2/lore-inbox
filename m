Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbRA0Ruq>; Sat, 27 Jan 2001 12:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130324AbRA0Rug>; Sat, 27 Jan 2001 12:50:36 -0500
Received: from [193.120.224.170] ([193.120.224.170]:34945 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129953AbRA0RuU>;
	Sat, 27 Jan 2001 12:50:20 -0500
Date: Sat, 27 Jan 2001 17:50:14 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: <linux-kernel@vger.kernel.org>
Subject: routing between different subnets on same if.
Message-ID: <Pine.LNX.4.32.0101271742250.15191-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm trying to get linux to do routing between 2 different subnets that
are on the same physical interface, because windows hosts don't seem
to accept the redirects.

how do i do it? how do i get linux to fully route between these
subnets on behalf of clients? turn send_redirects off doesn't work,
and nothing obvious shows up with 'ip route help'... (and there's no
man page for it to tell me).

i'm using the RedHat 2.2.16 kernel.

regards,

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
