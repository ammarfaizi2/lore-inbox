Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265647AbUABVYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbUABVYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:24:32 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:26523 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265647AbUABVYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:24:30 -0500
Date: Fri, 2 Jan 2004 22:23:24 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: DaMouse Networks <damouse@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.1-rc1-mm1 with r8169 driver
Message-ID: <20040102222324.A6827@electric-eye.fr.zoreil.com>
References: <20040102190704.4a05092d@EozVul.WORKGROUP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040102190704.4a05092d@EozVul.WORKGROUP>; from damouse@ntlworld.com on Fri, Jan 02, 2004 at 07:07:04PM +0000
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DaMouse Networks <damouse@ntlworld.com> :
> The r8169 Realtek driver hangs on bootup with the -mm1 patch but not with
> the plain -rc1 patch (IIRC) any ideas?

You can go to http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.0-test11 and
apply the patches to plain -rc1 in order as described in the readme file.
Once the patch which kills the driver is identified, I should be able to
clean my mess. 

(if someone knows a retail store in Paris where r8169 clones are available,
please drop me a mail, thanks)

--
Ueimor
