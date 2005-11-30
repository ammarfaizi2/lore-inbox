Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVK3Ou4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVK3Ou4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 09:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVK3Ou4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 09:50:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24030 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751258AbVK3Ouz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 09:50:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <E1EhT8Y-0003CF-00@dorka.pomaz.szeredi.hu> 
References: <E1EhT8Y-0003CF-00@dorka.pomaz.szeredi.hu>  <15253.1130246296@warthog.cambridge.redhat.com> <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com> <1130168619.19518.43.camel@imp.csi.cam.ac.uk> <1130167005.19518.35.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> <7872.1130167591@warthog.cambridge.redhat.com> <9792.1130171024@warthog.cambridge.redhat.com> <5425.1133359116@warthog.cambridge.redhat.com> 
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org, hugh@veritas.com,
       aia21@cam.ac.uk, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add notification of page becoming writable to VMA ops [try #3] 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 30 Nov 2005 14:50:39 +0000
Message-ID: <6715.1133362239@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > Updated to 2.6.14-git14.
> 
> But doesn't apply against 2.6.15-rc3 or -rc3-mm1.

Hmmm... It would appear that "The latest snapshot for the stable Linux kernel
tree" is a bit out of date on www.kernel.org. I should've checked the dates.

David
