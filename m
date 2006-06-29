Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751866AbWF2KqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbWF2KqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWF2KqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:46:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14567 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751355AbWF2KqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:46:13 -0400
Subject: Re: [PATCH] ia64: change usermode HZ to 250
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jes Sorensen <jes@sgi.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, John Daiker <jdaiker@osdl.org>,
       John Hawkes <hawkes@sgi.com>, Arjan van de Ven <arjan@infradead.org>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <yq04py4i9p7.fsf@jaguar.mkp.net>
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
	 <yq04py4i9p7.fsf@jaguar.mkp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Jun 2006 12:02:08 +0100
Message-Id: <1151578928.23785.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-29 am 05:37 -0400, ysgrifennodd Jes Sorensen:
> You have my vote for that one. Anything else is just going to cause
> those broken userapps to continue doing the wrong thing. We should
> really do this on all archs though.

No need, all current mainstream architectures expose a constant user HZ.

Alan

