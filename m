Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWECVEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWECVEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWECVEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:04:45 -0400
Received: from mail-a02.ithnet.com ([217.64.83.97]:32152 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S1751107AbWECVEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:04:44 -0400
X-Sender-Authentication: net64
Date: Wed, 3 May 2006 23:04:42 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       ja@ssi.bg
Subject: Re: Linux 2.6.16.13 / Problem
Message-Id: <20060503230442.d1575dab.skraw@ithnet.com>
In-Reply-To: <44590B62.6000107@tmr.com>
References: <20060502222827.GA29287@kroah.com>
	<20060503154532.a0963c65.skraw@ithnet.com>
	<44590B62.6000107@tmr.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 May 2006 15:58:26 -0400
Bill Davidsen <davidsen@tmr.com> wrote:

> Stephan von Krawczynski wrote:
> > Hi Greg,
> > 
> > unfortunately I see some problem regarding 2.6.16.13:
> > 
> Did you see this behavior in 2.6.16.11 or .12? In other words is this a 
> new problem, or one which just crawled out into view?

The box ran .11 since it existed without any troubles. The problems showed up
shortly after upgrading it to .13
I downgraded back to .11 now and everything is back to normal.

-- 
Regards,
Stephan

