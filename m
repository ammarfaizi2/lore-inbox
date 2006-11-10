Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965817AbWKJDgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965817AbWKJDgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 22:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966074AbWKJDgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 22:36:39 -0500
Received: from sandeen.net ([209.173.210.139]:34170 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S965817AbWKJDgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 22:36:39 -0500
Message-ID: <4553F3C6.2030807@sandeen.net>
Date: Thu, 09 Nov 2006 21:36:38 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
MIME-Version: 1.0
To: "Igor A. Valcov" <viaprog@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
In-Reply-To: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor A. Valcov wrote:

> I also noticed that I/O barriers were introduced in v2.6.16 and
> thought they may be the cause, but mounting the file system with
> 'nobarrier' doesn't seem to affect the performance in any way.


did this happen to be a remount with nobarrier, or a fresh mount?

-Eric
