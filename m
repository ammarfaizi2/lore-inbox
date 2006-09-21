Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWIUJOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWIUJOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWIUJOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:14:04 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:19389 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751062AbWIUJOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:14:02 -0400
Message-Id: <45127439.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 21 Sep 2006 11:15:05 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Mikael Pettersson" <mikpe@it.uu.se>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.18] x86_64: silence warning when stack
	unwinding is disabled
References: <200609210712.k8L7CdrR015591@alkaid.it.uu.se>
 <45125C4C.76E4.0078.0@novell.com> <200609211004.03942.ak@suse.de>
In-Reply-To: <200609211004.03942.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 21.09.06 10:04 >>>
>On Thursday 21 September 2006 09:33, Jan Beulich wrote:
>> A patch to this effect is already queued in -mm (and perhaps also in Andi's tree). Jan
>
>I refixed it independently a few minutes ago.
>
>There was also another compile error in my tree with unwind disabled which
>I fixed.

Thanks!
