Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbUBJToA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUBJToA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:44:00 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:19460 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S266074AbUBJTn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:43:59 -0500
Message-ID: <40293561.20402@tmr.com>
Date: Tue, 10 Feb 2004 14:47:45 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
References: <1ne1M-1Oc-1@gated-at.bofh.it>
In-Reply-To: <1ne1M-1Oc-1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Hi all,
> 
> Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
> thinking of restructuring the pty system slightly to make it more
> dynamic and to make use of the new larger dev_t, and I'd like to get
> rid of the BSD ptys as part of the same patch.
> 
> 	-hpa

