Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbTGGOUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 10:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267037AbTGGOUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 10:20:13 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:65178 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S265015AbTGGOUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 10:20:08 -0400
Date: Mon, 7 Jul 2003 16:34:35 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
Message-ID: <20030707143435.GA17400@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703023714.55d13934.akpm@osdl.org> <200307071424.06393.phillips@arcor.de> <20030707130905.GA13611@Synopsys.COM> <200307071633.15752.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307071633.15752.phillips@arcor.de>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips, Mon, Jul 07, 2003 16:33:15 +0200:
> On Monday 07 July 2003 15:09, Alex Riesen wrote:
> > Daniel Phillips, Mon, Jul 07, 2003 14:24:06 +0200:
> > > In retrospect, the idea of renicing all the applications but the
> > > realtime one  doesn't work, because it doesn't take care of
> > > applications started afterwards.
> >
> > start login niced to -X ?
> 
> Actually, the opposite: start login niced to +X (x ~= 5). ...

of course: "nice -5 /bin/login" is the login niced to +5.

