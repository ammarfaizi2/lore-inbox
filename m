Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbTGEVBt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbTGEVBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:01:49 -0400
Received: from holomorphy.com ([66.224.33.161]:4748 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266491AbTGEVBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:01:48 -0400
Date: Sat, 5 Jul 2003 14:17:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030705211740.GA15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, anton@samba.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <20030704210737.GI955@holomorphy.com> <20030704181539.2be0762a.akpm@osdl.org> <20030705104433.GK955@holomorphy.com> <20030705114308.6dacb5a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030705114308.6dacb5a2.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 05, 2003 at 11:43:08AM -0700, Andrew Morton wrote:
> if badness() returns zero for everything, this returns NULL and
> the kernel panics.

Sorry, that was one hell of an oversight wrt. the initival value.


-- wli
