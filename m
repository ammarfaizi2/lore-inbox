Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTLVW7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbTLVW7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:59:14 -0500
Received: from peabody.ximian.com ([141.154.95.10]:9180 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264547AbTLVW7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:59:12 -0500
Subject: Re: atomic copy_from_user?
From: Rob Love <rml@ximian.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       albert@users.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20031222223547.GA3737@rudolph.ccur.com>
References: <1072054100.1742.156.camel@cube>
	 <20031222150026.GD27687@holomorphy.com>
	 <20031222182637.GA2659@rudolph.ccur.com> <1072126506.3318.31.camel@fur>
	 <20031222141431.111e7611.akpm@osdl.org> <1072131587.3318.54.camel@fur>
	 <20031222223547.GA3737@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1072133949.3318.87.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 22 Dec 2003 17:59:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-22 at 17:35, Joe Korty wrote:

> Thanks, Robert and Andrew, for you explanations.  This patch should
> do the trick.

Looks right to me.  I like the comment, too.

	Rob Love


