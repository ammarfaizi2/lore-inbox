Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUHXVYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUHXVYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUHXVYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:24:51 -0400
Received: from holomorphy.com ([207.189.100.168]:20102 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268344AbUHXVXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:23:47 -0400
Date: Tue, 24 Aug 2004 14:23:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-ID: <20040824212345.GX2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org> <20040824205621.GU2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824205621.GU2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 01:56:21PM -0700, William Lee Irwin III wrote:
> fs/reiser4/context.c: In function `get_context_ok':
> fs/reiser4/context.c:88: warning: unsupported arg to `__builtin_return_address'
> fs/reiser4/context.c:89: warning: unsupported arg to `__builtin_return_address'
> fs/reiser4/context.c:90: warning: unsupported arg to `__builtin_return_address'

fs/reiser4/jnode.c: In function `jload_prefetch':
fs/reiser4/jnode.c:878: warning: passing arg 1 of `prefetchw' discards qualifiers from pointer target type
fs/reiser4/plugin/pseudo/pseudo.c: In function `get_rwx':
fs/reiser4/plugin/pseudo/pseudo.c:603: warning: comparison is always false due to limited range of data type


-- wli
