Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUHLXZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUHLXZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268880AbUHLXZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:25:15 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:23684 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268875AbUHLXXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:23:42 -0400
Message-ID: <411BFCD3.1070703@tmr.com>
Date: Thu, 12 Aug 2004 19:27:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Florian Schirmer <jolt@tuxbox.org>
CC: Matthias Andree <matthias.andree@gmx.de>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <20040811002455.GA7537@merlin.emma.line.org><20040811002455.GA7537@merlin.emma.line.org> <4119EF1D.2040102@tuxbox.org>
In-Reply-To: <4119EF1D.2040102@tuxbox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schirmer wrote:

> With burn-proof on you get a disc which is still usable but with some 
> pits/lands missing/misplaced. With burnproof off you get a completely 
> unusable disc. So whats the _real_ point behind disabling burn proof?

There are some people who would rather not have a CD at all if it is 
even slightly defective. Jorg is one of those, and I am for backups. I 
also verify backup CDs with his c2scan option to see just how clean the 
burn is.

There's an option, you can use it or not. Maybe a burnfree CD will be 
just as good in 3-4 years, but CDs are cheap, I'll burn another if need 
be. I don't know how much this helps, but I understand terms like "good 
faith effort" and "best practices." I have no problem with making the 
user specify that option.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
