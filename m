Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281200AbRKEQKf>; Mon, 5 Nov 2001 11:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281202AbRKEQKZ>; Mon, 5 Nov 2001 11:10:25 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:8709 "HELO abasin.nj.nec.com")
	by vger.kernel.org with SMTP id <S281200AbRKEQKJ>;
	Mon, 5 Nov 2001 11:10:09 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15334.47576.741548.776511@abasin.nj.nec.com>
Date: Mon, 5 Nov 2001 11:10:00 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: Re: Google's mm problems
In-Reply-To: <20011104032828Z16097-4784+757@humbolt.nl.linux.org>
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin>
	<20011103205601.2170.qmail@thales.mathematik.uni-ulm.de>
	<20011104032828Z16097-4784+757@humbolt.nl.linux.org>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With some in house code, on 2.4.14-pre8 I'm still getting some
unwanted swapping after filling up the cache that i'm not getting with
the 2.4.14-pre6aa1 kernel of a 4G system.  With pre8 if fills up the
memory with cache and does some minor swapping, on pre6aa1 it fills up
the memory with cache and happily works.

    Sven


