Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965653AbWIRKq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965653AbWIRKq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965654AbWIRKq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:46:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35539 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965653AbWIRKq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:46:26 -0400
Date: Mon, 18 Sep 2006 12:46:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] CPUFreq PowerOP integration, Centrino PM Core and OPs registration 2/3
Message-ID: <20060918104624.GB4973@elf.ucw.cz>
References: <45096C1A.7010008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45096C1A.7010008@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +/* 
> + * FIXME: very temporary implementation, just to prove the concept !! 
> + */
> +static int 
> +process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
> +		  int va_arg)

Ok, so can we get final implementation? Parsing strings in drivers is
evil...

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
