Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTIRVKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 17:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTIRVKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 17:10:18 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:35798 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262123AbTIRVKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 17:10:15 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 18 Sep 2003 23:10:06 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: BUG at mm/memory.c:1501 in 2.6.0-test5
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <95932E0ADB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Sep 03 at 13:43, William Lee Irwin III wrote:
> On Thu, Sep 18, 2003 at 10:27:58PM +0200, Petr Vandrovec wrote:
> > EIP:    0060:[<c015be10>]    Tainted: PF 
> 
>                 snprintf(buf, sizeof(buf), "Tainted: %c%c%c",
>                         tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
>                         tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
>                         tainted & TAINT_UNSAFE_SMP ? 'S' : ' ');
> 
> This is probably the reason you're not getting much in the way of a
> response.

I explicitly stated that it happened shortly after I shut down VMware UI,
and that I spent whole day trying to find what's going on, finally
politely asking for help, hoping that someone could have a clue
what went wrong.
                                            Petr Vandrovec


