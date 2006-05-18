Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWERINE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWERINE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWERINE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:13:04 -0400
Received: from mx0.towertech.it ([213.215.222.73]:19618 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1751259AbWERIND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:13:03 -0400
Date: Thu, 18 May 2006 10:12:55 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc subsystem, fix capability checks in kernel
 interface
Message-ID: <20060518101255.50fad256@inspiron>
In-Reply-To: <20060517235740.757f69a1.akpm@osdl.org>
References: <20060517021156.34cce7c9@inspiron>
	<20060517235740.757f69a1.akpm@osdl.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006 23:57:40 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
> >
> > 
> >  Remove CAP_SYS_XXX checks from the in kernel interface. Those
> >  functions are meant to be used in-kernel only.

> The changelog and the patch don't have much correlation.
> 
> Are you sure this was the right patch?

 I should have said "remove commented capability checks and
 add some others" :(

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

