Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWHQWsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWHQWsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWHQWsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:48:04 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:13440 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030313AbWHQWsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:48:04 -0400
Date: Fri, 18 Aug 2006 00:44:48 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed!
Message-ID: <20060817224448.GB3616@aitel.hist.no>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got 2.6.18-rc4-mm1 going, and it appears that system 
moves at about 3x normal speed.  A software clock need 3
seconds to advance 10 seconds, for example.

Everything else seems faster too, the keyboard autorepeat,
delay loops in games, and so on.  

Guess I could live with this, if it'd also compile
3x faster. :-/

This is a x86-64 kernel, with the jiffies hotfix applied.

Helge Hafting
