Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265223AbSJaNgn>; Thu, 31 Oct 2002 08:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265225AbSJaNgn>; Thu, 31 Oct 2002 08:36:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41734 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265223AbSJaNgm>;
	Thu, 31 Oct 2002 08:36:42 -0500
Date: Thu, 31 Oct 2002 13:43:08 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Where's the documentation for Kconfig?
Message-ID: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm just looking over the new arch/parisc/Kconfig trying to make sure that
it got translated correctly, but I can't find any documentation.  Some of
the Kconfig files refer to "the Configure script" -- what Configure
script?  Some of them refer to Documentation/kbuild/config-language.txt
-- which describes the old one.  Most don't tell you where to find
the description.

What's the difference between `help' and `---help---'?
What's the new idiom for define_bool?

-- 
Revolutions do not require corporate support.
