Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWIUIFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWIUIFA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWIUIFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:05:00 -0400
Received: from mx1.suse.de ([195.135.220.2]:35473 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751040AbWIUIE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:04:58 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH 2.6.18] x86_64: silence warning when stack unwinding is disabled
Date: Thu, 21 Sep 2006 10:04:03 +0200
User-Agent: KMail/1.9.3
Cc: "Mikael Pettersson" <mikpe@it.uu.se>, linux-kernel@vger.kernel.org
References: <200609210712.k8L7CdrR015591@alkaid.it.uu.se> <45125C4C.76E4.0078.0@novell.com>
In-Reply-To: <45125C4C.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609211004.03942.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 September 2006 09:33, Jan Beulich wrote:
> A patch to this effect is already queued in -mm (and perhaps also in Andi's tree). Jan

I refixed it independently a few minutes ago.

There was also another compile error in my tree with unwind disabled which
I fixed.

-Andi
