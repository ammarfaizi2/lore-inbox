Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVAKCSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVAKCSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVAKA5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:57:52 -0500
Received: from orb.pobox.com ([207.8.226.5]:3243 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262541AbVAKAoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:44:14 -0500
Date: Mon, 10 Jan 2005 16:44:09 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-os@analogic.com
Cc: Steve Bergman <steve@rueb.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
Message-ID: <20050111004409.GB4378@ip68-4-98-123.oc.oc.cox.net>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de> <41E2F6B3.9060008@rueb.com> <Pine.LNX.4.61.0501101707220.14001@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501101707220.14001@chaos.analogic.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:09:18PM -0500, linux-os wrote:
> Are you sure it's an exploit? My information was that grsecurity
> wanted some of their 'hooks' added to recent kernels and it hasn't
> happened. That's not a security problem, that's an application
> problem.

Yes, exploit (although the severity is arguable). See the 2.6.10-ac7
portion of the changelog here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110523047925271&w=2

-Barry K. Nathan <barryn@pobox.com>

