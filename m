Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136542AbRAHKlA>; Mon, 8 Jan 2001 05:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136771AbRAHKku>; Mon, 8 Jan 2001 05:40:50 -0500
Received: from colorfullife.com ([216.156.138.34]:27922 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136762AbRAHKkk>;
	Mon, 8 Jan 2001 05:40:40 -0500
Message-ID: <3A59993E.A4173025@colorfullife.com>
Date: Mon, 08 Jan 2001 11:41:02 +0100
From: manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: narancs1@externet.hu, linux-kernel@vger.kernel.org
Subject: Re: postgres/shm problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you run powertweak?

there is a new parameter

	/proc/sys/kernel/shmall

and some powertweak versions set it to 0.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
