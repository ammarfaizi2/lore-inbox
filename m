Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbUJ0HiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbUJ0HiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbUJ0HiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:38:12 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:1804 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262222AbUJ0HiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:38:11 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: The naming wars continue...
Date: Wed, 27 Oct 2004 10:37:56 +0300
User-Agent: KMail/1.5.4
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <417D7089.3070208@tmr.com> <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org> <417EC260.1010401@tmr.com>
In-Reply-To: <417EC260.1010401@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410271037.56090.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stop doing the pre's on the next version! After 2.6.10 comes 2.6.10.1 
> etc, which everyone can see are incremental changes to 2.6.10, and when 
> you really mean it, then put out 2.6.11-rc1.

Oh no. We had a perfectly working scheme of pre's and rc's,
why shall it be changed? This will break scripts for _zero_
gain.

Well, if Linus does not want pre's and wants to use rc's
only, that's fine with me, but fourth digit
(or other such innovations) is not.
--
vda

