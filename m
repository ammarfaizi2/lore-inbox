Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWCDRqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWCDRqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWCDRqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:46:43 -0500
Received: from mx0.towertech.it ([213.215.222.73]:50338 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932273AbWCDRqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:46:42 -0500
Date: Sat, 4 Mar 2006 18:46:11 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.fr>, p_gortmaker@yahoo.com
Subject: Re: [PATCH 04/13] RTC subsystem, class
Message-ID: <20060304184611.784fd939@inspiron>
In-Reply-To: <20060304170810.GE9295@stusta.de>
References: <20060304164247.963655000@towertech.it>
	<20060304164248.740384000@towertech.it>
	<20060304170810.GE9295@stusta.de>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Mar 2006 18:08:10 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> > +REAL TIME CLOCK (RTC) SUBSYSTEM
> > +P:	Alessandro Zummo
> > +M:	a.zummo@towertech.it
> > +L:	linux-kernel@vger.kernel.org
> > +S:	Maintained
> > +
> >...
> 
> The entry above the one you are adding is:
> 
> REAL TIME CLOCK DRIVER
> P:      Paul Gortmaker
> M:      p_gortmaker@yahoo.com
> L:      linux-kernel@vger.kernel.org
> S:      Maintained
> 
> 
> Two entries for the same thing only cause confusion.
>

 It is not the same thing. Paul's one is the standard rtc
 driver, which has not yet replaced by the rtc class.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

