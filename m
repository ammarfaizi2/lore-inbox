Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUAHTV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbUAHTV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:21:28 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:43783 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264452AbUAHTV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:21:28 -0500
Date: Thu, 8 Jan 2004 22:21:24 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Relocation overflow with modules on Alpha
Message-ID: <20040108222124.A691@den.park.msu.ru>
References: <1arJl-l5-9@gated-at.bofh.it> <1aNAg-5UM-29@gated-at.bofh.it> <1bKho-37e-25@gated-at.bofh.it> <E1Aecs0-0000Ew-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1Aecs0-0000Ew-00@neptune.local>; from der.eremit@email.de on Thu, Jan 08, 2004 at 05:18:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 05:18:52PM +0100, Pascal Schmidt wrote:
> Isn't this code also used for zisofs?

No. AFAIKS, zizofs uses zlib stuff.

Ivan.
