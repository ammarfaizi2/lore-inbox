Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUCLNdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUCLNdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:33:51 -0500
Received: from zero.aec.at ([193.170.194.10]:44806 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262099AbUCLNdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:33:49 -0500
To: Joe Thornber <thornber@redhat.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.4-mm1
References: <1yygN-7Ut-65@gated-at.bofh.it> <1yQdz-1Uf-7@gated-at.bofh.it>
	<1yRCI-3lE-19@gated-at.bofh.it> <1yTO6-5JU-25@gated-at.bofh.it>
	<1yU7Z-624-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 19 Mar 2004 07:00:02 +0100
In-Reply-To: <1yU7Z-624-11@gated-at.bofh.it> (Joe Thornber's message of
 "Fri, 12 Mar 2004 13:40:48 +0100")
Message-ID: <m3fzc5tlzx.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber <thornber@redhat.com> writes:
>
>> good candidate for next mm ?
>
> Yep, I'll forward a patch to akpm now.

Please don't do that. It will break all 64bit userland.

-Andi

