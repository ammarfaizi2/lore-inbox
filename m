Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145230AbRA2HWE>; Mon, 29 Jan 2001 02:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S159809AbRA2HVp>; Mon, 29 Jan 2001 02:21:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17305 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S145230AbRA2HVc>;
	Mon, 29 Jan 2001 02:21:32 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14965.6575.903857.642449@pizda.ninka.net>
Date: Sun, 28 Jan 2001 23:20:15 -0800 (PST)
To: David Lang <dlang@diginsite.com>
Cc: jamal <hadi@cyberus.ca>, James Sutherland <jas88@cam.ac.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.LNX.4.31.0101281856400.3329-100000@dlang.diginsite.com>
In-Reply-To: <Pine.GSO.4.30.0101281039440.24762-100000@shell.cyberus.ca>
	<Pine.LNX.4.31.0101281856400.3329-100000@dlang.diginsite.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Lang writes:
 > I am behind a raptor firewall and ran the test that David M posted a
 > couple days ago and was able to sucessfully connect to his test machine.
 > 
 > so either raptor tolorates ECN (at least in the verion I am running) or
 > the test was not valid.

Did you actually list a directory or something and make
sure my workstation made a new connection _back_ to you?

If you are using passive FTP and/or did not do a directory
listing, you did the test incorrectly.  The directory listing
is what will test the ECN'ness of your local firewall.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
