Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbTAKM0S>; Sat, 11 Jan 2003 07:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTAKM0S>; Sat, 11 Jan 2003 07:26:18 -0500
Received: from zamok.crans.org ([138.231.136.6]:36504 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S267203AbTAKM0S>;
	Sat, 11 Jan 2003 07:26:18 -0500
Date: Sat, 11 Jan 2003 13:35:04 +0100
To: Bertrand VIEILLE =?iso-8859-1?B?W0LpYmVydF0=?= 
	<Bertrand.Vieille@crans.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3-acX oops
Message-ID: <20030111123504.GB7731@darwin.gaia.net>
References: <20030110222008$074c@gated-at.bofh.it> <6599015.32TDcXEdQ7@adelaide.crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6599015.32TDcXEdQ7@adelaide.crans.org>
User-Agent: Mutt/1.4i
X-Warning: Email may contain unsmilyfied humor and/or satire.
From: Vincent Hanquez <tab@tuxfamily.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 12:18:17PM +0100, Bertrand VIEILLE [Bébert] wrote:
> EIP:    0010:[__free_pages_ok+637/672]    Tainted: P

Your kernel is tainted with a proprietary module.

>Process X (pid: 547, stackpage=f7257000)

and this is related to X. (nvidia proprietary module ?)
Does this oops happen without the module ?

-- 
Tab
