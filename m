Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbULZXC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbULZXC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 18:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULZXCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 18:02:51 -0500
Received: from albireo.enyo.de ([212.9.189.169]:56204 "EHLO albireo.enyo.de")
	by vger.kernel.org with ESMTP id S261252AbULZXCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 18:02:46 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: 7eggert@gmx.de
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [3/4]: Add support for ZEROED and NOT_ZEROED free maps
References: <fa.n0l29ap.1nqg39@ifi.uio.no> <fa.n04s9ar.17sg3f@ifi.uio.no>
	<E1ChwhG-00011c-00@be1.7eggert.dyndns.org>
Date: Mon, 27 Dec 2004 00:02:33 +0100
In-Reply-To: <E1ChwhG-00011c-00@be1.7eggert.dyndns.org> (Bodo Eggert's message
	of "Fri, 24 Dec 2004 22:10:02 +0100")
Message-ID: <87wtv464ty.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bodo Eggert:

> Christoph Lameter wrote:
>
>> o Add scrub daemon
>
> Please use names a simple user may understand.
>
> What about memcleand or zeropaged instead?

But overwritting with zeros is commonly called "scrubbing", as in
"password scrubbing".
