Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWARUtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWARUtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWARUtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:49:36 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:9476 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030439AbWARUtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:49:35 -0500
Date: Wed, 18 Jan 2006 15:48:49 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
       softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
Subject: Re: wireless: the contenders
Message-ID: <20060118204844.GE6583@tuxdriver.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jbenc@suse.cz,
	softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
References: <20060118200616.GC6583@tuxdriver.com> <43CEA6EB.6080209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CEA6EB.6080209@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 03:36:59PM -0500, Jeff Garzik wrote:
> John W. Linville wrote:

> >The "master" branch of that tree is (mostly) up-to-date w/ Linus, plus
> >changes I recently sent to Jeff.  Those changes are also available on
> >the "upstream-jgarzik" branch, but it is frozen to when I requested
> >Jeff's pull.

> Typically I do not update 'master' unless I am also updating 'upstream' 
> with vanilla Linus changes, in order to avoid screwing up the tree heads 
> and the diff.  When I do update 'master' from 'upstream', it is a 
> trivial matter to then pull those changes into 'upstream':

Good info...thanks!

FWIW, I have an "origin" branch that corresponds to Linus' tree.
I think that probably enables the same kind of usage as you noted...?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
