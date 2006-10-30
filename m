Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWJ3WQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWJ3WQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbWJ3WQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:16:01 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26513 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422694AbWJ3WQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:16:01 -0500
Subject: Re: Linux Freezes during disk IO on Asus M2NPV-VM nVidia chipset -
	raid 0 related?
From: Lee Revell <rlrevell@joe-job.com>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4546400C.1090500@perkel.com>
References: <4546400C.1090500@perkel.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 17:16:13 -0500
Message-Id: <1162246573.27037.60.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 10:10 -0800, Marc Perkel wrote:
> I hope this is enough information to help track this down.

I doubt it - someone would need to replicate your exact hardware and
config to debug this further, and you don't provide the information
needed to do so.

Try to reproduce the lockups from a text console instead of X - you
might get an Oops on the screen.

Lee

