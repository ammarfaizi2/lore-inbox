Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTLHWzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 17:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTLHWzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 17:55:52 -0500
Received: from main.gmane.org ([80.91.224.249]:14291 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261947AbTLHWzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 17:55:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: PROBLEM: BTTV option not available in make gconfig
Date: Mon, 08 Dec 2003 23:55:48 +0100
Message-ID: <yw1xzne2aphn.fsf@kth.se>
References: <vpq1xrfnd49.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:3hrX7WLmU8poU0a77AF4HAc4+rA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I'm upgrading my kernel to 2.6-test9

Why not -test11 while you're at it?

> The option CONFIG_VIDEO_BT848=m in .config was available in 2.4, but I
> can't find in  doing a "make gconfig" in the new  version. (This is to
> manage my Pinnacle PCTV card)

Say Y or M to I2O support.

-- 
Måns Rullgård
mru@kth.se

