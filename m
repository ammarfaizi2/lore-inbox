Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136176AbRECHw3>; Thu, 3 May 2001 03:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136182AbRECHwU>; Thu, 3 May 2001 03:52:20 -0400
Received: from geos.coastside.net ([207.213.212.4]:5262 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S136176AbRECHwI>; Thu, 3 May 2001 03:52:08 -0400
Mime-Version: 1.0
Message-Id: <p0510030ab716bdcf5556@[207.213.214.37]>
In-Reply-To: <80BTbI6mw-B@khms.westfalen.de>
In-Reply-To: <p05100303b70eadd613b0@[207.213.214.37]>
 <80BTbI6mw-B@khms.westfalen.de>
Date: Thu, 3 May 2001 00:51:25 -0700
To: kaih@khms.westfalen.de (Kai Henningsen)
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:32 AM +0200 2001-05-03, Kai Henningsen wrote:
>jlundell@pobox.com (Jonathan Lundell)  wrote on 26.04.01 in 
><p05100303b70eadd613b0@[207.213.214.37]>:
>
>>  At 10:31 PM -0600 2001-04-26, Richard Gooch wrote:
>>  >BTW: please fix your mailer to do linewrap at 72 characters. Your
>>  >lines are hundreds of characters long, and that's hard to read.
>>
>>  Sorry for the inconvenience. There are a lot of reasons why I believe
>>  it's properly a display function to wrap long lines, and that an MUA
>>  has no business altering outgoing messages (one on-topic reason being
>>  that patches get screwed up by inserted newlines), but I grant that
>>  there are broken clients out there that can't or won't or don't wrap
>>  at display time.
>
>What's a lot more important is that the mail standards say that this stuff 
>should not be interpreted by the receivers as needing wrapping, so 
>irregardless of good or bad design it's just plain illegal.
>
>If you want to support wrapping with plain text, investigate
>format=flowed.

Yes, I did that.

I'm curious, though: I haven't found the mail standards that forbid 
receivers to wrap long lines. Certainly many mail clients do it. 
What's the relevant RFC?

>MfG Kai


-- 
/Jonathan Lundell.
