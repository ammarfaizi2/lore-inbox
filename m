Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUCHO3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 09:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUCHO3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 09:29:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32691 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262490AbUCHO3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 09:29:15 -0500
Date: Mon, 8 Mar 2004 09:29:57 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Max Valdez <maxvalde@fis.unam.mx>
cc: linux-kernel@vger.kernel.org
Subject: Re: distcc crashes fedora 2.4.22-1.2149.nptl
In-Reply-To: <200403071852.18132.maxvalde@fis.unam.mx>
Message-ID: <Xine.LNX.4.44.0403080928240.22156-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2004, Max Valdez wrote:

> I know this is not the correct list to ask problems about fedora, but maybe 
> someone knows what can be happening, and what can I do to trace the problem 
> down. Should I try to install a vanilla kernel to see if that corrects the 
> problem ?

One of the fedora mailing lists would be a better place to post.

Do you have SELinux enabled?

Try and get a log of the kernel oops via serial console, or at least write 
down the traceback functions.


- James
-- 
James Morris
<jmorris@redhat.com>




