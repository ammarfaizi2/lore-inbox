Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136381AbRA1BPb>; Sat, 27 Jan 2001 20:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136333AbRA1BPV>; Sat, 27 Jan 2001 20:15:21 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:11322 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S136380AbRA1BPM>; Sat, 27 Jan 2001 20:15:12 -0500
Message-ID: <3A737297.64FC5CB5@linux.com>
Date: Sun, 28 Jan 2001 01:15:03 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <3A7295F6.621BBEC4@Home.com> <3A731E65.8BE87D73@pobox.com> <3A7359BB.7BBEE42A@linux.com> <94voof$17j$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is important to note that when I hit the magic key and rebooted (SUB), a
split second before it rebooted, a stalled 'lspci' snapped back to life and
printed out my expected data.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
