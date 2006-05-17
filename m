Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWEQHpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWEQHpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWEQHpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:45:06 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:10173 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750705AbWEQHpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:45:04 -0400
Date: Wed, 17 May 2006 09:45:03 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: fritzsch <fritzsch@cip.physik.uni-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: running only 1 process on 1 cpu
Message-ID: <20060517074503.GA19885@rhlx01.fht-esslingen.de>
References: <1147807902.6647.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147807902.6647.12.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 16, 2006 at 09:31:42PM +0200, fritzsch wrote:
> actually i wanted to ask if this could work and if there is maybe sth
> like this already somewhere implemented (or easily adaptable).
Implementing exactly this feature (a whole cpu dedicated to one process only
for extremely ambitious rt tasks) has been mentioned shortly during some
scheduler discussion here at most 4 weeks ago, but I don't recall the exact
thread.

Some Google keywords that might help:
lkml cpu exclusive scheduler rt latency reserve

Andreas Mohr
