Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129540AbRCBWAJ>; Fri, 2 Mar 2001 17:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129546AbRCBV77>; Fri, 2 Mar 2001 16:59:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33668 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129540AbRCBV7z>;
	Fri, 2 Mar 2001 16:59:55 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15008.6084.410042.53699@pizda.ninka.net>
Date: Fri, 2 Mar 2001 13:59:32 -0800 (PST)
To: Jim Woodward <jim@jim.southcom.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 TCP window shrinking
In-Reply-To: <Pine.LNX.4.33.0103030426210.12977-100000@jim.southcom.com.au>
In-Reply-To: <Pine.LNX.4.33.0103030426210.12977-100000@jim.southcom.com.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jim Woodward writes:
 > This has probably been covered but I saw this message in my logs and
 > wondered what it meant?
 > 
 > TCP: peer xxx.xxx.1.11:41154/80 shrinks window 2442047470:1072:2442050944.
 > Bad, what else can I say?
 > 
 > Is it potentially bad? - Ive only ever seen it twice with 2.4.x

We need desperately to know exactly what OS the xxx.xxx.1.14 machine
is running.  Because you've commented out the first two octets, I
cannot check this myself using nmap.

Later,
David S. Miller
davem@redhat.com
