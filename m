Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWEQIgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWEQIgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 04:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWEQIgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 04:36:24 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:43747 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932488AbWEQIgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 04:36:23 -0400
Date: Wed, 17 May 2006 10:36:22 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore partition table on disks with AIX label
Message-ID: <20060517083622.GA15627@rhlx01.fht-esslingen.de>
References: <20060517081314.GA20415@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517081314.GA20415@suse.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 17, 2006 at 10:13:14AM +0200, Olaf Hering wrote:
> +/* Value is EBCIDIC 'IBMA' */

Google "EBCIDIC EBCDIC"
--> http://burks.bton.ac.uk/burks/foldoc/18/36.htm

99.999% of all people have never ever heard of this important encoding anyway,
so better don't confuse them additionally ;)

Andreas Mohr
