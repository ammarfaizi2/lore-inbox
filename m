Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTBNR6S>; Fri, 14 Feb 2003 12:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbTBNR6S>; Fri, 14 Feb 2003 12:58:18 -0500
Received: from [66.62.77.7] ([66.62.77.7]:61140 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id <S263342AbTBNR6R>;
	Fri, 14 Feb 2003 12:58:17 -0500
Subject: Re: modutils that works with 2.4 and 2.5?
From: Dax Kelson <dax@gurulabs.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030214060024.GC9578@actcom.co.il>
References: <1045162343.1311.7.camel@mentor> 
	<20030214060024.GC9578@actcom.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Feb 2003 11:12:03 -0700
Message-Id: <1045246324.1301.1.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 23:00, Muli Ben-Yehuda wrote:
> On Thu, Feb 13, 2003 at 11:52:23AM -0700, Dax Kelson wrote:
> > Does such a thing exist?
> > 
> > I would like to help out testing 2.5, but I need to still use 2.4 as
> > well.
> 
> Rusty's modutils package maintains the old modutils binaries and falls
> back to them if it discovers that you're running a 2.4 system.

Does it do this discovery at install time, or at each boot?



