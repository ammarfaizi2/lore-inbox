Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269364AbUJLALQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269364AbUJLALQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUJLALQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:11:16 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:43656 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269364AbUJLALO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:11:14 -0400
Message-ID: <416B211E.409@yahoo.com.au>
Date: Tue, 12 Oct 2004 10:11:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org> <416A5857.1090307@yahoo.com.au> <Pine.LNX.4.58.0410110802590.3897@ppc970.osdl.org> <Pine.LNX.4.58.0410110822170.3897@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410110822170.3897@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 11 Oct 2004, Linus Torvalds wrote:
> 
>>That said, your patch is small and simple, so..
> 
> 
> Btw, out of interest, make it print out the "package->type" for the 
> failure case. It should be ACPI_TYPE_PACKAGE (4), I think, but..
> 

ACPI: element was NULL! package = 1
