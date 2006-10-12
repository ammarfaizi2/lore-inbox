Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWJLGtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWJLGtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWJLGtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:49:23 -0400
Received: from 1wt.eu ([62.212.114.60]:34308 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1161219AbWJLGtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:49:23 -0400
Date: Thu, 12 Oct 2006 08:49:15 +0200
From: Willy Tarreau <w@1wt.eu>
To: jplatte@naasa.net
Cc: =?iso-8859-1?Q?G=FCnther?= Starnberger <gst@sysfrog.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Userspace process may be able to DoS kernel
Message-ID: <20061012064914.GF5050@1wt.eu>
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com> <200610120802.59077.lists@naasa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610120802.59077.lists@naasa.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 08:02:58AM +0200, Joerg Platte wrote:
> Am Mittwoch, 11. Oktober 2006 18:54 schrieb Günther Starnberger:
> 
> > I will upgrade my 2.6.17.6 kernel to 2.6.18 and try to reproduce the
> > problem there in the following days (but I fear that I won't have much
> > time before the weekend).
> 
> Using 2.6.18 does not solve the problem. I can see exactly the same behavior 
> with a vanilla and not tainted 2.6.18 kernel.

Just out of curiosity, does the system still respond to ping during this
period, and does the time still progress during the lock up ? Not that it
could help me find out what's happening, but it might help troubleshooting
the problem.

Regards,
Willy

