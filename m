Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTLBWfK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 17:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTLBWfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 17:35:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45479 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264428AbTLBWfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 17:35:06 -0500
Message-ID: <3FCD1388.2020907@pobox.com>
Date: Tue, 02 Dec 2003 17:34:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
References: <3FCB4506.8080305@wanadoo.es> <Pine.LNX.4.44.0312011209000.13692-100000@logos.cnet> <bqj2al$dmc$1@gatekeeper.tmr.com>
In-Reply-To: <bqj2al$dmc$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> Unless a miracle occurs it will take as long for 2.6 to be really stable
> and fully functional as it did for 2.[024]. When it goes out in distros
> and gets abused by users for a while the sharp corners will be broken off.


I think that's a bit of an extremist view.

The 2.6 rpms Arjan has posted have gotten good use, and most people seem 
to think 2.6.0-test is a _lot_ more stable than 2.4.0 was at release time.

It's certainly true that a raft of currently-unknown bugs will show up 
when distros start shipping 2.6-based distros (I think the first was 
Mandrake, as an experimental extra, soon be followed by Fedora?).  Such 
bugs always appear.

I venture to say, for the vast majority of hardware, including my 28MB 
K6-2 laptop and my P133 firewall, 2.6 works just as well as 2.4 does 
currently.

	Jeff


