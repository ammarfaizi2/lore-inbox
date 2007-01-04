Return-Path: <linux-kernel-owner+w=401wt.eu-S964802AbXADMFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbXADMFZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 07:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbXADMFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 07:05:25 -0500
Received: from mx0.towertech.it ([213.215.222.73]:44141 "HELO mx0.towertech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964802AbXADMFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 07:05:24 -0500
Date: Thu, 4 Jan 2007 13:05:19 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: "Voipio Riku" <Riku.Voipio@movial.fi>, rtc-linux@googlegroups.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       dan.j.williams@intel.com, i2c@lm-sensors.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.19-git] rts-rs5c372 updates:  more chips, alarm,
 12hr mode, etc
Message-ID: <20070104130519.0acf9c0b@inspiron>
In-Reply-To: <200701032023.36660.david-b@pacbell.net>
References: <200612081859.42995.david-b@pacbell.net>
	<200701021907.25701.david-b@pacbell.net>
	<42235.80.222.56.248.1167864702.squirrel@webmail.movial.fi>
	<200701032023.36660.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007 20:23:35 -0800
David Brownell <david-b@pacbell.net> wrote:

> > 
> > Works fine, thanks! Unfortunately the i2c-ixp3xx issue has not advanced in
> > the meantime, so we still need the third method.  
> 
> Right.  Thanks for confirming this!  Alessandro?

 Given that we can not test on more boards, I'd keep
 the most compatible method.

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

