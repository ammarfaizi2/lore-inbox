Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319061AbSH2EFh>; Thu, 29 Aug 2002 00:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319089AbSH2EFh>; Thu, 29 Aug 2002 00:05:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48543 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319061AbSH2EFg>;
	Thu, 29 Aug 2002 00:05:36 -0400
Date: Wed, 28 Aug 2002 21:04:09 -0700 (PDT)
Message-Id: <20020828.210409.67510643.davem@redhat.com>
To: cw@f00f.org
Cc: spotter@cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: tcp_hashinfo exported or not?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020828220935.GA12963@tapu.f00f.org>
References: <1030503622.487.2.camel@zaphod>
	<20020827.204259.44983328.davem@redhat.com>
	<20020828220935.GA12963@tapu.f00f.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Wedgwood <cw@f00f.org>
   Date: Wed, 28 Aug 2002 15:09:35 -0700

   Conditionally exporting symbols based upon CONFIG_* is a PITA.  Do we
   really need to do this and will you accept a patch making go away?
   
Nobody else should need to get at the TCP hash tables.

Are you trying to work on a proprietary binary-only implementation of
Linux IPv6 TCP :-)

Franks a lot,
David S. Miller
davem@redhat.com
