Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTLSLKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 06:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTLSLKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 06:10:06 -0500
Received: from holomorphy.com ([199.26.172.102]:46998 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262683AbTLSLKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 06:10:01 -0500
Date: Fri, 19 Dec 2003 03:09:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] linux.bkbits.net
Message-ID: <20031219110957.GM31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tupshin Harper <tupshin@tupshin.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FE2D4D5.2050103@softhome.net> <20031219104050.GK31393@holomorphy.com> <3FE2D7F7.9010703@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE2D7F7.9010703@tupshin.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> You may have missed Linus' announcement: 2.6.0 has been released.

On Fri, Dec 19, 2003 at 02:50:31AM -0800, Tupshin Harper wrote:
> Uh...no. He's talking about the fact that it is conceptually odd to pull 
> a 2.6(final) linux from a 2.5 URL. That's all.
> -Tupshin

bk pull doesn't require an argument; it defaults to using the stored
parent repository. So "normally" the name of the repository wouldn't
be seen or given at all. If it moved, it would cause an error when
the parent repository could not be found.

Regardless of whether the state of affairs under discussion is altered,
the above is why it wasn't a consideration in my original reply.


-- wli
