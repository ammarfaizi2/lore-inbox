Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269847AbTGKI16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269857AbTGKI15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:27:57 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:8714 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269847AbTGKI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:27:54 -0400
Date: Fri, 11 Jul 2003 09:42:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.75
Message-ID: <20030711094228.B21196@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <p73isqaos29.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0307101709360.5091-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307101709360.5091-100000@home.osdl.org>; from torvalds@osdl.org on Thu, Jul 10, 2003 at 05:12:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 05:12:43PM -0700, Linus Torvalds wrote:
> Do we have distributions that intend to make releases using those? I
> suspect not, but hey, don't get me wrong: I'd love to see them working
> out-of-the-box.

RH AS and SLES support s390 and ppc64.  OTOH their trees are
patched to death so who cares :)

ppc32 is pretty important as lots of kernel developers love mac
hardware.  (Writing this from an ibook..)

