Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUIARzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUIARzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUIARwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:52:32 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:60818 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S267359AbUIAPyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:54:40 -0400
Message-ID: <4135F0BB.8040503@hotmail.com>
Date: Wed, 01 Sep 2004 11:54:35 -0400
From: Colin <cwvca_spammr@hotmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/4] v4l: bttv driver update.
References: <20040831152405.GA15658@bytesex>
In-Reply-To: <20040831152405.GA15658@bytesex>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
>   Hi,
> 
> This patch is a minor update for the bttv driver.  Changes:
> 
>   * add a few new tv cards.
>   * add some infrastructure needed by the dvb drivers (for bt878-based
>     dvb cards).
>   * improve croma line selection for planar video formats,
>   * some new debug printk's

Will this patch fix the problem with channels being one off from where 
they're suppose to be?  I can't even tune into channel 6 because of it.
