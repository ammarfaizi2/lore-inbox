Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbTBCS4I>; Mon, 3 Feb 2003 13:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbTBCS4I>; Mon, 3 Feb 2003 13:56:08 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:60048 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266969AbTBCS4H>;
	Mon, 3 Feb 2003 13:56:07 -0500
Date: Mon, 3 Feb 2003 19:02:05 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: John Bradford <john@grabjohn.com>, Seamus <assembly@gofree.indigo.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: CPU throttling??
Message-ID: <20030203190205.GA15256@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Valdis.Kletnieks@vt.edu, John Bradford <john@grabjohn.com>,
	Seamus <assembly@gofree.indigo.ie>, linux-kernel@vger.kernel.org
References: <200302031713.h13HD2K8000181@darkstar.example.net> <200302031857.h13IvHa0025735@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302031857.h13IvHa0025735@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 01:57:17PM -0500, Valdis.Kletnieks@vt.edu wrote:

 > It's conceivable that a CPU halted at 1.2Gz takes less power than one
 > at 1.6Gz - anybody have any actual data on this?  Alternately phrased,
 > does CPU throttling save power over and above what the halt does?

Given that most decent implementations scale voltage as well as
frequency, yes, a lower speed will save more power.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
