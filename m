Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbUJaJo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUJaJo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 04:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUJaJo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 04:44:56 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:45476 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261516AbUJaJow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 04:44:52 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc1-mm2: konqueror segfaults for no reason (2nd update)
Date: Sun, 31 Oct 2004 10:45:44 +0100
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200410291823.34175.rjw@sisk.pl> <20041030150452.GF20611@wotan.suse.de>
In-Reply-To: <20041030150452.GF20611@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410311045.44159.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 of October 2004 17:04, Andi Kleen wrote:
> On Fri, Oct 29, 2004 at 06:23:34PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On 2.6.10-rc1-mm2 with SuSE 9.1 /x86_64 konqueror always crashes for no 
> > specific reason and the following messages appear in dmesg:
> > 
> > local[18494]: segfault at 0000003000000018 rip 0000000000428f2a rsp 
> > 0000007fbfffe870 error 4
> > local[18493]: segfault at 0000003000000018 rip 0000000000428f2a rsp 
> > 0000007fbfffe870 error 4
> > 
> > This does not happen on 2.6.10-rc1.
> 
> I tested this now too and konqueror also works fine for me.

Have you tried to open pages containing JavaScript?  It turns out that my 
konqueror(s) work(s) fine on 2.6.10-rc1-mm2 when I disable JavaScript in it 
(them).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
