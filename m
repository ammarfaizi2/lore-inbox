Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWKBHJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWKBHJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbWKBHJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:09:30 -0500
Received: from main.gmane.org ([80.91.229.2]:33693 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751880AbWKBHJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:09:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [patch] make the Makefile mostly stay within col 80
Date: Thu, 2 Nov 2006 07:09:19 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnekj6ps.2in.olecom@flower.upol.cz>
References: <200611020047.53658.jesper.juhl@gmail.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>, Jesper Juhl <jesper.juhl@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, trivial@kernel.org
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-01, Jesper Juhl wrote:
> Trivial little thing really. 
> Try to make most of the Makefile obey the 80 column width rule.

I'm already working on it. I did a lot more stuff, but currently i'm
stuck with very first patch, i've tried to push to mister Andrew:
<http://marc.theaimsgroup.com/?l=linux-mm-commits&m=116198944205036&w=2>

As i'm using emacs, i cann't revert this open/save/close patch every
time. If someone with RH-based distro is willing to help, i'll be glad.
Version of make is Red Hat make-3.80-10.2.

Also, i want Sam Ravnborg to comment on that effort (e-mail added). Thanks.
____

