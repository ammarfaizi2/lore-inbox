Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263099AbUJ1XpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263099AbUJ1XpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUJ1Xor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:44:47 -0400
Received: from siaag2aa.compuserve.com ([149.174.40.131]:54154 "EHLO
	siaag2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263099AbUJ1XiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:38:11 -0400
Date: Thu, 28 Oct 2004 19:33:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: My thoughts on the "new development model"
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Message-ID: <200410281937_MC3-1-8D69-AAD0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004 at 08:03:29 -0700 William Lee Irwin III wrote:

> 99.99% of users use one arch, i386.

  You oversimplify.  For example, I have:

        1 uniprocessor IOAPIC (i440FX)
        1 SMP IOAPIC (flat mode) (i440GX)
        2 XT-PIC noapic (i440BX, VIA KT133)


> 99.99% of users use one disk driver, IDE.

  And again:

        1 VIA VT82C686
        1 HPT370A
        1 PDC20267
        1 PDC20268
        1 PIIX3
        2 PIIX4

  So even in my 'simple' i386 environment there is a lot of variety in
just those two things.


> The intersection of these users is probably well over 99.999% of all
> users.

  If Linux had a billion users, how many would have something different?


--Chuck Ebbert  28-Oct-04  19:04:08
