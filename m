Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272692AbTG1HCk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272689AbTG1HBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:01:32 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:20997 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272687AbTG1HAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:00:31 -0400
Date: Mon, 28 Jul 2003 08:15:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: keyboard controller by default if not embedded
Message-ID: <20030728081545.C1707@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <200307272004.h6RK49Ae029610@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307272004.h6RK49Ae029610@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Jul 27, 2003 at 09:04:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again this is crap and make no sense for most x86 subarches except
X86_PC.  And means useless bloat for all my modwern PeeCees with USB
keyboard and mouse.

