Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbULAW1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbULAW1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbULAW1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:27:12 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:19637 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261436AbULAW1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:27:08 -0500
Message-ID: <41AE4515.3090100@tmr.com>
Date: Wed, 01 Dec 2004 17:26:29 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4
References: <20041130095045.090de5ea.akpm@osdl.org><20041130095045.090de5ea.akpm@osdl.org> <20041201211036.GQ2650@stusta.de>
In-Reply-To: <20041201211036.GQ2650@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>>...
>>All 618 patches:
>>...
>>add-acpi-based-floppy-controller-enumeration.patch
>>  Add ACPI-based floppy controller enumeration.
>>...
> 
> 
> As far as I understood the discussion, this patch should be dropped.

Does this patch help or hinder operation on laptops with external 
pluggable floppies? And why wouldn't ACPI be a good thing here?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
