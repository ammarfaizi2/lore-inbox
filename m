Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUDITHO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 15:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUDITHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 15:07:13 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:14347 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261680AbUDITGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 15:06:53 -0400
Date: Fri, 9 Apr 2004 23:06:51 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: =?koi8-r?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>, linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-ID: <20040409230651.A727@den.park.msu.ru>
References: <yw1xsmftnons.fsf@ford.guide> <20040328201719.A14868@jurassic.park.msu.ru> <yw1xoeqhndvl.fsf@ford.guide> <20040328204308.C14868@jurassic.park.msu.ru> <20040328221806.7fa20502@vaio.gigerstyle.ch> <yw1xr7vcn1z2.fsf@ford.guide> <20040329205233.5b7905aa@vaio.gigerstyle.ch> <20040404121032.7bb42b35@vaio.gigerstyle.ch> <20040409134534.67805dfd@vaio.gigerstyle.ch> <20040409134828.0e2984e5@vaio.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040409134828.0e2984e5@vaio.gigerstyle.ch>; from gigerstyle@gmx.ch on Fri, Apr 09, 2004 at 01:48:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 01:48:28PM +0200, Marc Giger wrote:
> > Presently, I reached a stage on which I don't know longer what to
> > do:-( I isolated the problem between 2.6.3-rc1 and 2.6.3-rc2. I
>                                        ^^^^^^^^^^^^^^^^^^^^^^^
>                                read as 2.6.4-rc1 and 2.6.4-rc2

Thanks for your work.

> > also reverted 1.1608.56.1 , 1.1608.51.36 and all xfs related patches
> > from rc2 with no luck.
> > All other changes seems unrelated to me.

I'd also revert 1.1608.51.22 and all networking changes.

Ivan.
