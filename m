Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTDOJ1H (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 05:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTDOJ1H (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 05:27:07 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:21764 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S264414AbTDOJ1F (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 05:27:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200304151128.2775@gandalf>
To: Bill Huey (Hui) <billh@gnuppy.monkey.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.67-mm3
Date: Tue, 15 Apr 2003 11:38:55 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030414181302.0da41360.akpm@digeo.com> <20030415013447.GA3592@gnuppy.monkey.org>
In-Reply-To: <20030415013447.GA3592@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 April 2003 03:34, Bill Huey (Hui) wrote:
> On Mon, Apr 14, 2003 at 06:13:02PM -0700, Andrew Morton wrote:
> > Could be anything.   Does sysrq not work?
> > 
> > If not, please send me your .config.
> 
> It does it with elevator=deadline too. I'll see if I can get you better
> dump.

no problems here (running with anticipatory scheduling elevator), current 
uptime is 18h. 
the only problem I have is that kmod does not seem to work, modules has to be 
inserted manually... probably a problem with module-init-tools.

	Rudmer
