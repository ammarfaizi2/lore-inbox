Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSGGSKd>; Sun, 7 Jul 2002 14:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSGGSKc>; Sun, 7 Jul 2002 14:10:32 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:13795 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316322AbSGGSKc>; Sun, 7 Jul 2002 14:10:32 -0400
Date: Sun, 7 Jul 2002 19:12:32 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: M?ns Rullg?rd <mru@users.sourceforge.net>,
       Mohamed Ghouse Gurgaon <MohamedG@ggn.hcltech.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Diff b/w 32bit & 64-bit
Message-ID: <20020707191232.A11999@kushida.apsleyroad.org>
References: <yw1xpty71bea.fsf@gladiusit.e.kth.se> <200207012152.g61LqjX387143@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207012152.g61LqjX387143@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Mon, Jul 01, 2002 at 05:52:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
> don't cast from "foo *" to "bar *" if sizeof(foo)<sizeof(bar)

What is the reason for this?  I do it quite routinely ("poor man's
inheritance").

cheers,
-- Jamie
