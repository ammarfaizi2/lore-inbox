Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270327AbTHLNe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270328AbTHLNe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:34:29 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:60801 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S270327AbTHLNe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:34:28 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jurriaan on adsl-gate <thunder7@xs4all.nl>
Date: Tue, 12 Aug 2003 15:34:12 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test3: matrox framebuffer halts booting?
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <9ECCAFB4EFB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Aug 03 at 13:34, Jurriaan on adsl-gate wrote:
> If I try to boot a self-compiled kernel with the matrox framebuffer, the
> booting process halts after 'Freeing unused kernel memory'.
> 
> After that, the system isn't hung (numlock works, ctrl-alt-del works)
> but it also doesn't boot (not reachable over the network, blindly
> logging in doesn't work). Before that, the framebuffer seems to work - I
> see a resolution change and a penguin boot-logo.

Did you tried whether alt-sysrq-p or shift/ctrl/alt-scrolllock do not 
produce some reasonable hint about where it got stuck?
                                                    Petr

