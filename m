Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUG2R3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUG2R3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUG2R0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:26:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12726 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264808AbUG2RXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:23:47 -0400
Date: Thu, 29 Jul 2004 13:23:35 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Andries Brouwer <aebr@win.tue.nl>
cc: Andrew Morton <akpm@osdl.org>, <dpf-lkml@fountainbay.com>,
       <linux-kernel@vger.kernel.org>, <aeb@cwi.nl>
Subject: Re: [PATCH] Delete cryptoloop
In-Reply-To: <20040729161203.GB4008@pclin040.win.tue.nl>
Message-ID: <Xine.LNX.4.44.0407291320580.16390-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Andries Brouwer wrote:

> # Part of the reason for dropping cryptoloop is to help dm-crypt
> # mature more quickly.
> 
> A very strange reason. But maybe it fits in with dropping the idea
> of a stable kernel.

Well, now that the kernel development model has changed (there may not be
a 2.7 in the forseeable future), just when do you drop buggy, unmaintained
code?

- James
-- 
James Morris
<jmorris@redhat.com>


