Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSLQMah>; Tue, 17 Dec 2002 07:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSLQMah>; Tue, 17 Dec 2002 07:30:37 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51606 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264983AbSLQMag>;
	Tue, 17 Dec 2002 07:30:36 -0500
Date: Tue, 17 Dec 2002 12:38:06 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Xavier LaRue <paxl@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: My cpu fuzzy problem was due to XMMS
Message-ID: <20021217123806.GA10589@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Xavier LaRue <paxl@videotron.ca>, linux-kernel@vger.kernel.org
References: <20021217011600.08f8cd81.paxl@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021217011600.08f8cd81.paxl@videotron.ca>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 01:16:00AM -0500, Xavier LaRue wrote:
 > :).. I just found it out :)
 > 
 > But now my real problem.. That probably slow down considerably my box,
 > How to make my L2 cache reconized
 > my dmesg is hosted here http://paxl.no-ip.org/~paxl/dmesg.txt

As I've pointed out twice to you now, 2.4.18 had a bug in the
CPU cache sizing routine that is fixed in 2.4.21pre1

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
