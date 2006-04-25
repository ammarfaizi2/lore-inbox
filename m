Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWDYPuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWDYPuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWDYPuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:50:15 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:6832 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751388AbWDYPuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:50:13 -0400
Date: Tue, 25 Apr 2006 17:50:12 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is there an easy way to collect how much memory is used for page cache?
Message-ID: <20060425155012.GA19041@rhlx01.fht-esslingen.de>
References: <4ae3c140604250827y67675fednba67ffdb67405b87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ae3c140604250827y67675fednba67ffdb67405b87@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 25, 2006 at 11:27:08AM -0400, Xin Zhao wrote:
> Specifically, how much memory is used to cache data for file systems? 
> Any way to measure it?

cat /proc/slabinfo, possibly?

Andreas Mohr

-- 
Please consider not buying any HDTV hardware! (extremely anti-consumer)
Bitte kaufen Sie besser keinerlei HDTV-Geräte! (extrem verbraucherfeindlich)
Infos:
http://www.hdboycott.com   http://www.eff.org/IP/DRM/   http://bluraysucks.com
