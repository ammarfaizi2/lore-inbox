Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWJKHCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWJKHCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 03:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWJKHCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 03:02:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57000 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932450AbWJKHCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 03:02:39 -0400
Subject: Re: [PATCH 2.6.19-rc1-mm1] Export jiffies_to_timespec()
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <452C3CA6.2060403@goop.org>
References: <452C3CA6.2060403@goop.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 11 Oct 2006 09:02:27 +0200
Message-Id: <1160550147.3000.349.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 17:36 -0700, Jeremy Fitzhardinge wrote:
> Export jiffies_to_timespec; previously modules used the inlined header version.

any chance you'll tell us which modules? :)


