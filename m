Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288827AbSANGeV>; Mon, 14 Jan 2002 01:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288820AbSANGeJ>; Mon, 14 Jan 2002 01:34:09 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:50304 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288827AbSANGdv>; Mon, 14 Jan 2002 01:33:51 -0500
Date: Mon, 14 Jan 2002 08:32:32 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <timothy.covell@ashavan.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: strange kernel message when hacking the NIC driver
Message-ID: <Pine.LNX.4.33.0201140831240.28735-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell <timothy.covell@ashavan.org> said:
>If you try to reach a host but fail due to routing issues, then ICMP sends out
>DESTINATION HOST UNKNOWN/HOST UNREACHABLE messages.
>So, ICMP and very much to do with ARP.

Using your argument... Everytime my feline decides to chew my ethernet
cable i lose my network connection, hence i get ICMP HOST UNREACHABLE ergo
my cat has very much to do with ARP.

Those are errors just filtering up the layers, same way an app doesn't
know anything about what device you're writing to, but will complain about
incomplete data writes if you run out of space.

Regards,
	Zwane Mwaikambo


