Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbTKUN6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 08:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTKUN6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 08:58:35 -0500
Received: from holomorphy.com ([199.26.172.102]:16050 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264361AbTKUN6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 08:58:33 -0500
Date: Fri, 21 Nov 2003 05:58:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4
Message-ID: <20031121135810.GR22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20031118225120.1d213db2.akpm@osdl.org> <3FBDCCDF.9010304@gmx.de> <20031121130810.GQ22764@holomorphy.com> <3FBE19E8.6000802@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBE19E8.6000802@gmx.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> diff -prauN mm4-2.6.0-test9-1/mm/memory.c
[...]

On Fri, Nov 21, 2003 at 02:58:00PM +0100, Prakash K. Cheemplavam wrote:
> Great, with that patch the rest of the warnings disappeared.
> Though still one thing left (probably nothing serious). Since mm3 I get 
> this when starting X/kde at the very end of dmesg:
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).

Unfortunately, this one I don't know how to fix (though I'm not
entirely sure it means anything bad is going on, either).


-- wli
