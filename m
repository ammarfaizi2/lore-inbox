Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUGASjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUGASjf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUGASjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:39:35 -0400
Received: from main.gmane.org ([80.91.224.249]:20913 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266217AbUGASje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:39:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Subject: Re: framebuffer + fbtv + X kills system
Date: Thu, 1 Jul 2004 20:39:31 +0200
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <cc1lp3$2d1$1@sea.gmane.org>
References: <cc1ajv$5bs$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd952a595.dip.t-dialin.net
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE> wrote:
> I'm further running a XFree86 X-Server (with `Driver "tdfx"',
> `Option "UseFBDev" "true"', `DefaultDepth 24' and `Modes

Hm, replying to myself :)
I finally discovered, that using XFree with Driver !fbdev and
Option UseFBDev true doesn't really mean that the framebuffer
has total display control.
So it could be, that this is it what finally confuses the
framebuffer.

Sorry for the inconvenience (and the long mail around it :)).


regards,
   Mario
-- 
User sind wie ideale Gase - sie verteilen sich gleichmaessig ueber alle Platten

