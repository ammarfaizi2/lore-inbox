Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272688AbTG1G7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272689AbTG1G7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:59:53 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:19461 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272688AbTG1G7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:59:34 -0400
Date: Mon, 28 Jul 2003 08:14:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: mouse and keyboard by default if not embedded
Message-ID: <20030728081447.B1707@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <200307272003.h6RK3ckm029604@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307272003.h6RK3ckm029604@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Jul 27, 2003 at 09:03:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again this is stupid.  With the select CONFIG_INPUt if CONFIG_VT people
get this asked now on make oldconfig.  Even more important many ports
newer used PS/2 style mouses previously as did older PeeCees.

Please stop this over-eager spreading of CONFIG_EMBEDDED, we're not
gnome..

