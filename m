Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWJXMMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWJXMMM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWJXMML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:12:11 -0400
Received: from main.gmane.org ([80.91.229.2]:36834 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161007AbWJXMMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:12:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Link lib to a kernel module
Date: Tue, 24 Oct 2006 12:11:47 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnejs14h.93p.olecom@flower.upol.cz>
References: <20061024105518.GA55219@server.idefix.loc>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: Oleg Verych <olecom@flower.upol.cz>, LKML <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
User-Agent: slrn/0.9.8.1pl1 (Debian)
Cc: kbuild-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, Matthias.

On 2006-10-24, Matthias Fechner wrote:

> I tried today to link a lib (.a) to my kernel module but I could not
> found howto do it.

`Documentation/kbuild' directory in your linux sources.
`makefiles.txt' about `lib-y',
`modules.txt'   about modules.

Good luck.
____

