Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSD2Hvk>; Mon, 29 Apr 2002 03:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291401AbSD2Hvj>; Mon, 29 Apr 2002 03:51:39 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:51384 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S288748AbSD2Hvj>; Mon, 29 Apr 2002 03:51:39 -0400
Date: Mon, 29 Apr 2002 09:51:22 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: First working version of suspend-to-RAM
Message-ID: <20020429075122.GD2740@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020428211754.GA9679@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2002 at 11:17:54PM +0200, Pavel Machek wrote:

> Seems that suspend-to-ram needs stopping all processes, too. I had to
> combine S3 patches with swsusp to make it possible. That means that
> you get suspend-to-disk for free with the bundle ;-).

Could you please reread Documentation/SubmittingPatches, especially
these 2 points:
  * No MIME, no links, no compression, no attachments.  Just plain text.
  * usage of 'dontdiff'

I'm sure this will help people try out your patch and give you
feedback...

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
