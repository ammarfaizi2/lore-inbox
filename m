Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbVAFVU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVAFVU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVAFVSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:18:36 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27302 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262969AbVAFVRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:17:05 -0500
Message-ID: <41DDAB4C.4070305@tmr.com>
Date: Thu, 06 Jan 2005 16:19:08 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: Dave Jones <davej@redhat.com>, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zap the ACPI shutdown bug (was Re: Reviving the concept
 of a stable series)
References: <20050104182017.GE19167@redhat.com><20050104182017.GE19167@redhat.com> <20050106182336.GB2390@ip68-4-98-123.oc.oc.cox.net>
In-Reply-To: <20050106182336.GB2390@ip68-4-98-123.oc.oc.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:

> If the "backport" jokes don't make sense yet, consider this dilemma: If
> a backported patch has not been committed upstream yet, then is it
> really a backport?

If a patch is against a later base and is rediffed to be against an 
earlier base, hopefully with side effects controlled, I think it's 
reasonable to call it a backport.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
