Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbULMAut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbULMAut (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 19:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbULMAut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 19:50:49 -0500
Received: from main.gmane.org ([80.91.229.2]:20148 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261940AbULMAun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 19:50:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Typo in kernel configuration (xconfig)
Date: Mon, 13 Dec 2004 01:50:30 +0100
Message-ID: <yw1xacsjm36x.fsf@ford.inprovide.com>
References: <BAY21-F18905FD4E8F32BE43C85BCF3AA0@phx.gbl> <Pine.LNX.4.61.0412130114510.3369@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:SI1zk9dYxKIaAN+Qxe7Xm5pKC64=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> writes:

> On Sun, 12 Dec 2004, Danny Beaudoin wrote:
>
>> Hi!
>> If I'm not at the right place, please forward this to the right person.
>> 
>> In Device Drivers/Graphics Support/Support for frame buffer devices:
>> "On several non-X86 architectures, the frame buffer device is the
>> only way to use the graphics hardware."
>> 
>> This should be 'x86' instead, as in the rest of the description.
>> 
> I don't think you are right. On x86 the framebuffer is not your only 
> option, and on some non-x86 archs (like alpha for instance - at least 
> this used to be the case when last I had an alpha box), fb is the 
> only option.

My Alphas all have VGA graphics, with the standard text modes
available.  Some of the older models may have had other types of
graphics.

-- 
Måns Rullgård
mru@inprovide.com

