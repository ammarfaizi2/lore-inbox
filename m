Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263469AbTJLMIM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 08:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTJLMIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 08:08:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37006 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263469AbTJLMIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 08:08:10 -0400
Date: Sun, 12 Oct 2003 13:07:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Brownell <david-b@pacbell.net>
Cc: Peter Matthias <espi@epost.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: ACM USB modem on Kernel 2.6.0-test
Message-ID: <20031012120734.GE13427@mail.shareable.org>
References: <3F8851A7.3000105@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8851A7.3000105@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> Hmm ... maybe usbcore would be better off with a less
> naive algorithm for choosing defaults.  Like, preferring
> configurations without proprietary device protocols.
> That'd solve every cdc-acm case, and likely others.

Presumably 2.4 does that, because my acm modem works with 2.3 and 2.4
kernels.

Do you know anything about the proprietary protocols, btw?

-- Jamie
