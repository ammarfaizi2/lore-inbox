Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWBPTeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWBPTeV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWBPTeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:34:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20130 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932560AbWBPTeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:34:20 -0500
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
From: Arjan van de Ven <arjan@infradead.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.OSF.4.05.10602161956400.20911-100000@da410>
References: <Pine.OSF.4.05.10602161956400.20911-100000@da410>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 20:34:15 +0100
Message-Id: <1140118455.4117.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 20:06 +0100, Esben Nielsen wrote:
> I just jump into a thread somewhere to ask my question :-)
> 
> Why does the list have to be in userspace?

because it's faster ;)



