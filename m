Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWHACrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWHACrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWHACrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:47:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:53187 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030405AbWHACrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:47:01 -0400
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86_64 built-in command line
Date: Tue, 1 Aug 2006 04:46:54 +0200
User-Agent: KMail/1.9.3
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060731171442.GI6908@waste.org> <200608010444.04681.ak@suse.de> <44CEC068.9060409@zytor.com>
In-Reply-To: <44CEC068.9060409@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010446.54021.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> True; it would just mean that the buildin command line would have to 
> double %'s, but that's not really a problem.

Similar for &s

-Andi
