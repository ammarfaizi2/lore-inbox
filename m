Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318802AbSIPFFS>; Mon, 16 Sep 2002 01:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318804AbSIPFFS>; Mon, 16 Sep 2002 01:05:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37599 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318802AbSIPFFS>;
	Mon, 16 Sep 2002 01:05:18 -0400
Date: Sun, 15 Sep 2002 22:01:31 -0700 (PDT)
Message-Id: <20020915.220131.104193664.davem@redhat.com>
To: alex14641@yahoo.com
Cc: TheUnforgiven@attbi.com, linux-kernel@vger.kernel.org
Subject: Re: To Anyone with a Radeon 7500 board and the ali developer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020916042625.55842.qmail@web40509.mail.yahoo.com>
References: <20020916042625.55842.qmail@web40509.mail.yahoo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Davis <alex14641@yahoo.com>
   Date: Sun, 15 Sep 2002 21:26:25 -0700 (PDT)

   Just out of curiosity, do you have AGPMode set to any value other than "1"
   in your XF86Config file? If so, try setting it to "1".
   
More importantly, set it to whatever value you have configured in
your BIOS setup.  There are lots of chipsets for which the AGP
mode change is not implemented fully/correctly in the AGP kernel
drivers.
