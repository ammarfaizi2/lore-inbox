Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVIII5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVIII5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbVIII51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:57:27 -0400
Received: from mx1.suse.de ([195.135.220.2]:9360 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965104AbVIII5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:57:24 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] x86-64 cmpxchg adjustment
Date: Fri, 9 Sep 2005 10:57:07 +0200
User-Agent: KMail/1.8
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43207CEA020000780002451A@emea1-mh.id2.novell.com>
In-Reply-To: <43207CEA020000780002451A@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091057.07709.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 18:03, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
>
> While only cosmetic for x86-64, this adjusts the cmpxchg code
> appearantly
> inherited from i386 to use more generic constraints.

Attachment is empty.

-Andi
