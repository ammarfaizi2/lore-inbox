Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbTBTG6N>; Thu, 20 Feb 2003 01:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTBTG6N>; Thu, 20 Feb 2003 01:58:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29382 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264878AbTBTG6M>;
	Thu, 20 Feb 2003 01:58:12 -0500
Date: Wed, 19 Feb 2003 22:51:59 -0800 (PST)
Message-Id: <20030219.225159.68317599.davem@redhat.com>
To: cw@f00f.org
Cc: toml@us.ibm.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPSec protocol application order
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030220005729.GA22880@f00f.org>
References: <OF67D9F550.2E100257-ON86256CD2.007CE0BF-86256CD2.007E9FBD@pok.ibm.com>
	<1045704729.14999.2.camel@rth.ninka.net>
	<20030220005729.GA22880@f00f.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Wedgwood <cw@f00f.org>
   Date: Wed, 19 Feb 2003 16:57:29 -0800
   
   someone could patch setkey to warn if it's told to do something bogus,
   with optional command line switch to silence this or whatever

True.  Whether this is wanted would be up to the KAME people
though.  They are the maintainers of setkey and racoon.
