Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbRGEFba>; Thu, 5 Jul 2001 01:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266623AbRGEFbU>; Thu, 5 Jul 2001 01:31:20 -0400
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:38528 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S266622AbRGEFbJ>;
	Thu, 5 Jul 2001 01:31:09 -0400
Date: Thu, 5 Jul 2001 07:29:29 +0200
From: Stefan Traby <stefan@hello-penguin.com>
To: Mark Swanson <swansma@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loop device corruption in 2.4.6
Message-ID: <20010705072929.A7922@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <01070417140200.03178@test.home2.mark>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <01070417140200.03178@test.home2.mark>; from swansma@yahoo.com on Wed, Jul 04, 2001 at 05:14:02PM -0400
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.5-fijiji2-aescrypto (i686)
X-APM: 99% -1 min
X-PGP: Key fingerprint = C090 8941 DAD8 4B09 77B1  E284 7873 9310 3BDB EA79
X-MIL: A-6172171143
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 1 8 13 25 36 38
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2001 at 05:14:02PM -0400, Mark Swanson wrote:

> I get repeatable errors with 2.4.6 patched with the international encryption 
> patch patch-int-2.4.3.1.bz2 when building loop device filesystems on top of 
> Reiserfs.

Well, exactly this happens here on 2.4.5 and earlier too...

I can't verify this on 2.4.6 (plain) because the kernel hangs right after
partition-check on my Thinkpad A21p. :(

-- 

  ciao - 
    Stefan

                     CONFIG_HANG_AFTER_PARTITION_CHECK=y
