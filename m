Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbUJ3P7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUJ3P7D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUJ3PqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:46:22 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:21897 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261285AbUJ3Ppa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:45:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2: konqueror segfaults for no reason
Date: Sat, 30 Oct 2004 17:42:33 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
References: <200410291823.34175.rjw@sisk.pl> <20041030150452.GF20611@wotan.suse.de>
In-Reply-To: <20041030150452.GF20611@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410301742.33433.rjw@sisk.pl>
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

Have you tested this on an SMP machine?  Mine is a UP.  I'll chek a dual 
Opteron box in a couple of minutes.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
