Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275076AbTHQISA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 04:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275078AbTHQIR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 04:17:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41995 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275076AbTHQIR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 04:17:59 -0400
Date: Sun, 17 Aug 2003 09:17:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Doug McNaught <doug@mcnaught.org>, "David D. Hagood" <wowbagger@sktc.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Message-ID: <20030817091754.A13616@flint.arm.linux.org.uk>
Mail-Followup-To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Doug McNaught <doug@mcnaught.org>,
	"David D. Hagood" <wowbagger@sktc.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200308170410.30844.mhf@linuxmail.org> <200308162049.h7GKnwnP024716@turing-police.cc.vt.edu> <3F3EB8FA.1080605@sktc.net> <m3oeypb3au.fsf@varsoon.wireboard.com> <20030816234104.GF710@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030816234104.GF710@gallifrey>; from gilbertd@treblig.org on Sun, Aug 17, 2003 at 12:41:04AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 12:41:04AM +0100, Dr. David Alan Gilbert wrote:
> (I seem to remember ARM Linux actually does log user exceptions and very
> useful it is too).

Of course, this is configurable via a debugging option...

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

