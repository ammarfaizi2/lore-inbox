Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWG3MBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWG3MBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWG3MBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:01:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932290AbWG3MBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:01:12 -0400
Date: Sun, 30 Jul 2006 05:01:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: CIJOML <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe nsc-ircc dongle_id=0x08 doesn't find chip in
 2.6.18-rc2
Message-Id: <20060730050109.16a967ea.akpm@osdl.org>
In-Reply-To: <200607281229.04183.cijoml@volny.cz>
References: <200607281229.04183.cijoml@volny.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 12:29:04 +0200
CIJOML <cijoml@volny.cz> wrote:

> Please have a lok at this bugreport:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6916
> 

It says:

Most recent kernel where this bug did not occur: 2.6.18-rc2
Distribution: Debian Testing
Hardware Environment: Acer TravelMate 242
Software Environment: kernel 2.6.18-rc2

Which isn't correct.  What is the correct answer to the first question? 
ie: the most recent not-buggy kernel version?
