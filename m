Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbUKXXJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbUKXXJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUKXXGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:06:22 -0500
Received: from [213.146.154.40] ([213.146.154.40]:14824 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262894AbUKXXCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:02:33 -0500
Date: Wed, 24 Nov 2004 23:02:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
Message-ID: <20041124230232.GA22509@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296414.5805.286.camel@desktop.cunninghams> <20041124132949.GB13145@infradead.org> <m2d5y23o61.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2d5y23o61.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 01:57:58PM -0800, Jan Rychter wrote:
> Obviously you have never actually tried to use software suspend in real
> life.
> 
> I would kindly suggest that you try to use it on your laptop for at
> least several weeks in various circumstances. These features are a
> result of years of user experience.

I tend to buy laptops that just suspend when closing the lid, and no, I never
had the strange desired to immediately reverse my choice.  Neither do I want
to stop the shutdown that I just initiated.

But for those people who do shutdown has a nice option to delay the actual
shutdown/reboot - I'm pretty sure the same can be done for swsusp without
sprinkling hooks all over the kernel.
