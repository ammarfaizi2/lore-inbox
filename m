Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264074AbSIVMM6>; Sun, 22 Sep 2002 08:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264078AbSIVMM6>; Sun, 22 Sep 2002 08:12:58 -0400
Received: from p508B55A1.dip.t-dialin.net ([80.139.85.161]:63919 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S264074AbSIVMM4>; Sun, 22 Sep 2002 08:12:56 -0400
Date: Sun, 22 Sep 2002 14:17:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 8/9: MIPS trace support
Message-ID: <20020922141739.A7293@linux-mips.org>
References: <3D8D58D8.56951976@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8D58D8.56951976@opersys.com>; from karim@opersys.com on Sun, Sep 22, 2002 at 01:44:56AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 01:44:56AM -0400, Karim Yaghmour wrote:

> This patch adds MIPS trace support.

The MIPS stuff is all looking drastically different now so while your
patch may apply to Linus's sources (which don't compile for MIPS anyway)
but not to any actually working copy of the MIPS kernel.

Sorry ...

  Ralf
