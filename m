Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWBMDAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWBMDAH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 22:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWBMDAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 22:00:07 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:1546 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751155AbWBMDAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 22:00:06 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Brandon Low <lostlogic@lostlogicx.com>
Subject: Re: Athlon 64 X2 cpuinfo oddities
Date: Mon, 13 Feb 2006 03:00:10 +0000
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com> <p73r77gx36u.fsf@verdi.suse.de> <20060213025322.GW4394@lostlogicx.com>
In-Reply-To: <20060213025322.GW4394@lostlogicx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602130300.10473.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 02:53, Brandon Low wrote:
> Did the patch that fixes the out of sync cpufreq messages make it into
> 2.6.15 stable series?  I just acquired an athlon 64 x2 system, and was
> having this:

My issues with cpufreq were resolved in 2.6.16-rc2, I highly recommend that 
you try it, or Linus's recently pushed -rc3.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
