Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUE0ST2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUE0ST2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbUE0ST2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:19:28 -0400
Received: from calvin.stupendous.org ([213.84.70.4]:2308 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S264923AbUE0ST0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:19:26 -0400
Date: Thu, 27 May 2004 20:19:46 +0200
From: Jurjen Oskam <jurjen@stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Badness in local_bh_enable at kernel/softirq.c:122
Message-ID: <20040527181946.GA1864@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040527174509.GA1654@quadpro.stupendous.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527174509.GA1654@quadpro.stupendous.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 07:45:10PM +0200, Jurjen Oskam wrote:
> 
> I'm using pptp-linux to connect to my ADSL-provider. I've been doing this
> for several years now, without significant problems. A week ago, I
> upgraded

... to Slackware 9.1 and installed kernel 2.6.5.

(Also, it seems to cause random text to disappear from mails sent to
linux-kernel, but I'll post a separate re
-- 
Jurjen Oskam

"Avoid putting a paging file on a fault-tolerant drive, such as a mirrored
volume or a RAID-5 volume. Paging files do not need fault-tolerance."-MS Q308417
