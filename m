Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272680AbTHEMDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272681AbTHEMDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:03:05 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:37528 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S272680AbTHEMDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:03:02 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Tue, 5 Aug 2003 14:02:38 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: decoded problem in 2.4.22-pre10
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <9433E945C9B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Aug 03 at 12:20, Stephan von Krawczynski wrote:
> On Tue, 5 Aug 2003 10:00:40 +0200
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> > Hello all,
> > 
> > the testbox crashed again this night, unfortunately I made a mistake
> > yesterday and started vmware once. Although only the usual modules were
> > loaded at crash time and not the application, the kernel was tainted of
> > course. Nevertheless I present the data:
> 
> I re-checked the setup with vmware and found out I can shoot it down in no
> time. So you probably should just forget about this bug report, because loading
> vmware modules does obviously do harm.

Any details? Were there some warning while vmmon was built?
                                                            Petr
                                                            

