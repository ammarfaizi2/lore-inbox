Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263395AbRFNRB0>; Thu, 14 Jun 2001 13:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbRFNRBQ>; Thu, 14 Jun 2001 13:01:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37297 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263395AbRFNRBG>;
	Thu, 14 Jun 2001 13:01:06 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15144.60850.545471.763348@pizda.ninka.net>
Date: Thu, 14 Jun 2001 10:00:34 -0700 (PDT)
To: Aaron Sethman <androsyn@ratbox.org>
Cc: John <cmptradm@bigfoot.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 kernel on Sparc32
In-Reply-To: <Pine.LNX.4.33.0106141259580.22582-100000@squeaker.ratbox.org>
In-Reply-To: <3B142AE0.20A22175@bigfoot.com>
	<Pine.LNX.4.33.0106141259580.22582-100000@squeaker.ratbox.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Aaron Sethman writes:
 > I've seen the exact same problem when trying to compile for sparc.  I
 > might try and fix it myself, as it doesn't seemed to be fixed in the vger
 > cvs tree, or any other patch for that matter.

The problem is that we lack a maintainer for the 32-bit Sparc
port, and the situation is unlikely change until someone steps
up to take over maintaining the thing.

Later,
David S. Miller
davem@redhat.com
