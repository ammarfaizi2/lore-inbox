Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbVIILDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVIILDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbVIILDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:03:12 -0400
Received: from smtp11.wanadoo.fr ([193.252.22.31]:561 "EHLO smtp11.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1030237AbVIILDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:03:10 -0400
X-ME-UUID: 20050909110309419.667EB1C00061@mwinf1112.wanadoo.fr
Date: Fri, 9 Sep 2005 13:07:02 +0200
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <JBeulich@novell.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Message-ID: <20050909110702.GA787@zaniah>
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <200509091054.11932.ak@suse.de> <43216EFB020000780002489B@emea1-mh.id2.novell.com> <200509091123.59205.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509091123.59205.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2005 at 11:23 +0000, Andi Kleen wrote:

 
> Indeed. Someone must have fixed it.  But why would anyone want frame pointers
> on x86-64?

Oprofile can use it, I though it was already used but apparently only
to backtrace userspace actually.

-- 
Philippe Elie

