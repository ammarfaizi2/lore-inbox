Return-Path: <linux-kernel-owner+w=401wt.eu-S964856AbWLMAtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWLMAtA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWLMAs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:48:59 -0500
Received: from mx0.towertech.it ([213.215.222.73]:39765 "HELO mx0.towertech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964852AbWLMAs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:48:58 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 19:48:58 EST
Date: Tue, 12 Dec 2006 21:46:59 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [patch 2.6.19-git] rtc, remove syslog spam on registration
Message-ID: <20061212214659.042d5bf9@inspiron>
In-Reply-To: <200612121123.56778.david-b@pacbell.net>
References: <200612121123.56778.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 11:23:55 -0800
David Brownell <david-b@pacbell.net> wrote:

> This removes some syslog spam as RTC drivers register; debug messages 
> shouldn't come out at "info" level.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

 Thanks David,

   please also cc rtc-linux@googlegroups.com on future patches.


 Acked-by: Alessandro Zummo <a.zummo@towertech.it>
-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

