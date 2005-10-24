Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVJXGc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVJXGc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 02:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVJXGc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 02:32:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15528 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751023AbVJXGc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 02:32:57 -0400
Date: Sun, 23 Oct 2005 23:32:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       clameter@sgi.com, torvalds@osdl.org, linux-mm@kvack.org
Subject: Re: [PATCH] cpuset confine pdflush to its cpuset
Message-Id: <20051023233237.0982b54b.pj@sgi.com>
In-Reply-To: <20051024.145258.98349934.taka@valinux.co.jp>
References: <20051024001913.7030.71597.sendpatchset@jackhammer.engr.sgi.com>
	<20051024.145258.98349934.taka@valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahashi-san wrote:
> I realized CPUSETS has another problem around pdflush.

Excellent observation.  I had not realized this.

Thank-you for pointing it out.

I don't have plans.  Do you have any suggestions?

  ( Anyone know what the "pd" stands for in pdflush ?? )

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
