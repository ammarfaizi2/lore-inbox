Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTD0Mka (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 08:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263958AbTD0Mka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 08:40:30 -0400
Received: from zero.aec.at ([193.170.194.10]:3854 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263120AbTD0Mk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 08:40:29 -0400
Date: Sun, 27 Apr 2003 14:52:38 +0200
From: Andi Kleen <ak@muc.de>
To: Riley Williams <Riley@Williams.Name>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support worst case cache line sizes as config option
Message-ID: <20030427125238.GA1083@averell>
References: <20030427022346.GA27933@averell> <BKEGKPICNAKILKJKMHCAAEPNCIAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEGKPICNAKILKJKMHCAAEPNCIAA.Riley@Williams.Name>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 01:36:45PM +0200, Riley Williams wrote:
> Does the order of those "default" lines actually matter?
> Your moving that one to the top of the list appears to imply that it does.

I don't know if it matters, probably not.

-Andi
