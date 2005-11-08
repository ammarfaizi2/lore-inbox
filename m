Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965652AbVKHAsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965652AbVKHAsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965654AbVKHAsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:48:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:44461 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965652AbVKHAsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:48:36 -0500
Date: Mon, 7 Nov 2005 16:48:31 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] Memory Add Fixes for ppc64
Message-ID: <20051108004831.GG5821@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com> <20051108003901.GO12353@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108003901.GO12353@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 11:39:01AM +1100, Anton Blanchard wrote:
> Ive got a patch that reworks our numa code and it might reject with
> your stuff. I'll send them out for review this afternoon.

Interesting in that I was going to start reworking some of the
numa code to make it play nice with hot add.  Doubt this patch
set will impact your changes.  This set is not very intelligent
WRT numa and doesn't really modify any of the real code.

-- 
Mike
