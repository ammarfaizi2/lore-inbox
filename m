Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUJ3XL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUJ3XL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUJ3XJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:09:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261425AbUJ3XGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:06:52 -0400
Date: Sat, 30 Oct 2004 19:06:47 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Z Smith <plinius@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel GUI project
In-Reply-To: <4184124B.4090602@comcast.net>
Message-ID: <Pine.LNX.4.44.0410301905460.8844-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004, Z Smith wrote:

> I've been developing an in-kernel 2D GUI for kernel 2.6.
> It's based on the framebuffer with the event subsystem

What about video cards where the framebuffer does not
provide for acceleration, but the X drivers do ?

Do you plan to use the X server for better performance
on such systems ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

