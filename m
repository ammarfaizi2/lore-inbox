Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWJLRUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWJLRUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWJLRUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:20:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42429 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751432AbWJLRUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:20:18 -0400
Subject: Re: Hardware bug or kernel bug?
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200610121753.23220.dj@david-web.co.uk>
References: <200610121753.23220.dj@david-web.co.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 12 Oct 2006 19:20:15 +0200
Message-Id: <1160673616.3000.441.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 17:53 +0100, David Johnson wrote:
> Hi,
> 
> I'm having a major problem on a system that I've been unable to track down. 
> When using scp to transfer a large file (a few gig) over the network 
> (@100Mbit/s) the system will reboot after about 5-10 minutes of transfer. No 
> errors, just a reboot. I have another identical system which exhibits the 
> same behaviour.


could be a heat issue.... although.. the rest of what you describe
doesn't quite match that. Still.. just opening the case and using an
external fan to blow air in for 10 minutes should entirely disprove that
I suppose..

