Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264084AbUKZUUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbUKZUUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263958AbUKZUUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:20:08 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:56227 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263956AbUKZT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:56:05 -0500
Subject: Re: Suspend 2 merge: 17/51: Disable MCE checking during suspend.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125181954.GG1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101295216.5805.256.camel@desktop.cunninghams>
	 <20041125181954.GG1417@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1101420341.27250.58.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:05:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 05:19, Pavel Machek wrote:
> Hi!
> 
> > Avoid a potential SMP deadlock here.
> 
> ..and loose MCE report.

Deadlock or get an MCE report and do a printk when we're shutting down
anyway?
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

