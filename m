Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUG2DRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUG2DRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 23:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUG2DRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 23:17:11 -0400
Received: from zero.aec.at ([193.170.194.10]:27916 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263893AbUG2DRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 23:17:09 -0400
To: Will Cohen <wcohen@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 32-bit daemon on 64-bit AMD64
References: <410669CA.2030900@redhat.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 29 Jul 2004 05:17:05 +0200
In-Reply-To: <410669CA.2030900@redhat.com> (Will Cohen's message of "Tue, 27
 Jul 2004 10:42:18 -0400")
Message-ID: <m3k6wnmrim.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Cohen <wcohen@redhat.com> writes:
>
> Looks like the wrapper between 32-bit user-space and 64-bit
> kernel-space has problems.

There wasn't one. I fixed this now in my tree.

-Andi

