Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312489AbSDJKcF>; Wed, 10 Apr 2002 06:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312562AbSDJKcF>; Wed, 10 Apr 2002 06:32:05 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:43403 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312489AbSDJKcE>; Wed, 10 Apr 2002 06:32:04 -0400
Date: Wed, 10 Apr 2002 12:31:48 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bttv-driver broken in 2.5.8-pre
Message-ID: <20020410103148.GD28413@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"Udo A. Steinberg" <reality@delusion.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CB40AF0.693C5130@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 11:50:40AM +0200, Udo A. Steinberg wrote:

> The bttv driver in 2.5.8-pre doesn't compile:
[...]

> Gerd's latest patch v4l2-01-v4l2-api-2.5.8-pre2.diff doesn't fix it either.

You need the other patches in the same directory, especially this one:
	http://bytesex.org/patches/2.5/fix-video-01-video-drivers-2.5.8-pre2.diff

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
