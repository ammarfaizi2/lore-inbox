Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267631AbUHJSVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267631AbUHJSVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUHJR44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:56:56 -0400
Received: from zero.aec.at ([193.170.194.10]:3845 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267487AbUHJRzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:55:05 -0400
To: Jeff Mahoney <jeffm@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: File sizes > 2 GB on isofs?
References: <2rIVi-16U-45@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 10 Aug 2004 19:55:01 +0200
In-Reply-To: <2rIVi-16U-45@gated-at.bofh.it> (Jeff Mahoney's message of
 "Tue, 10 Aug 2004 19:50:16 +0200")
Message-ID: <m33c2u6fpm.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney <jeffm@suse.com> writes:

> With DVDs becoming widely popular for personal data storage, this 2 GB
> limit will probably become more and more of an issue.

That is what UDF was for created, wasn't it?

-Andi

