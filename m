Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281460AbRKPQvd>; Fri, 16 Nov 2001 11:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRKPQvX>; Fri, 16 Nov 2001 11:51:23 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:48558 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S281460AbRKPQvP>;
	Fri, 16 Nov 2001 11:51:15 -0500
Date: Fri, 16 Nov 2001 11:50:23 -0500
Subject: Re: /proc/stat description for proc.txt
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
To: Andreas Dilger <adilger@turbolabs.com>
From: Anthony DeRobertis <asd@suespammers.org>
In-Reply-To: <20011115115939.I5739@lynx.no>
Message-Id: <06F0B144-DAB2-11D5-B38E-00039355CFA6@suespammers.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.475)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  10:29 -0500, Sven Heinicke wrote:
> +cpu  58903 1 7337 221340
> +
> +The individual "cpu" entry is will be the same as "cpu0" if you only
> +have one CPU on your system.  Otherwise the "cpu" entry will be a
> +total of all the separate CPU stats.

Isn't the first sentence redundant? Also, the second one is a 
little confusing because "Otherwise..." implies a difference, 
when there is none.

