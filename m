Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143415AbREKWvS>; Fri, 11 May 2001 18:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143416AbREKWvI>; Fri, 11 May 2001 18:51:08 -0400
Received: from intranet.resilience.com ([209.245.157.33]:54239 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S143415AbREKWu7>; Fri, 11 May 2001 18:50:59 -0400
Mime-Version: 1.0
Message-Id: <p0510030db7221c090810@[10.128.7.49]>
In-Reply-To: <20010511133242.B3224@bacchus.dhis.org>
In-Reply-To: <p05100303b70eadd613b0@[207.213.214.37]>
 <80BTbI6mw-B@khms.westfalen.de> <p0510030ab716bdcf5556@[207.213.214.37]>
 <20010511133242.B3224@bacchus.dhis.org>
Date: Fri, 11 May 2001 15:49:05 -0700
To: Ralf Baechle <ralf@uni-koblenz.de>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:32 PM -0300 2001-05-11, Ralf Baechle wrote:
>On Thu, May 03, 2001 at 12:51:25AM -0700, Jonathan Lundell wrote:
>>  Kai Henningsen wrote:
>>  >What's a lot more important is that the mail standards say that this stuff
>>  >should not be interpreted by the receivers as needing wrapping, so
>>  >irregardless of good or bad design it's just plain illegal.
>>  >
>>  >If you want to support wrapping with plain text, investigate
>>  >format=flowed.
>>
>>  Yes, I did that.
>>
>  > I'm curious, though: I haven't found the mail standards that forbid
>>  receivers to wrap long lines. Certainly many mail clients do it.
>>  What's the relevant RFC?
>
>RFC 2822, 2.1.1.

Thanks. It's not quite a standard yet, but it's true, it does limit 
lines to 998 characters. Sort of a strange limit, but there you 
are....

-- 
/Jonathan Lundell.
