Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbTFRTok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbTFRTok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:44:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37646 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265257AbTFRTog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:44:36 -0400
Date: Wed, 18 Jun 2003 20:58:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jaakko Niemi <liiwi@lonesom.pp.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
Message-ID: <20030618205827.B12994@flint.arm.linux.org.uk>
Mail-Followup-To: Jaakko Niemi <liiwi@lonesom.pp.fi>,
	linux-kernel@vger.kernel.org
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi> <20030615191125.I5417@flint.arm.linux.org.uk> <87el1vcdrz.fsf@jumper.lonesom.pp.fi> <20030615212814.N5417@flint.arm.linux.org.uk> <87he6qc3bb.fsf@jumper.lonesom.pp.fi> <20030616085403.A5969@flint.arm.linux.org.uk> <3EEE173A.8040802@telia.com> <20030616212700.J13312@flint.arm.linux.org.uk> <3EEEAA9C.5060801@telia.com> <87wufjmahp.fsf@jumper.lonesom.pp.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87wufjmahp.fsf@jumper.lonesom.pp.fi>; from liiwi@lonesom.pp.fi on Wed, Jun 18, 2003 at 10:49:54PM +0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 10:49:54PM +0300, Jaakko Niemi wrote:
> Next, how to get my d-link dwl-650 wlan card up and running. If I insert
> it, link light on it lights up, and cardctl sees it in socket. However
> the drivers do not find it, and there is no interface available. This
> happens at least with 2.5.70 to .72. Anyone got suggestions where to
> start looking?

Anything in /var/log/messages from cardmgr?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

