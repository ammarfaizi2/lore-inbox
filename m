Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWEEQdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWEEQdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWEEQdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:33:38 -0400
Received: from mx0.towertech.it ([213.215.222.73]:30631 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1751158AbWEEQdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:33:38 -0400
Date: Fri, 5 May 2006 18:32:09 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: James Chapman <jchapman@katalix.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DS1337 RTC subsystem driver
Message-ID: <20060505183209.67e22e77@inspiron>
In-Reply-To: <20060505154322.GA7078@linux-mips.org>
References: <20060505154322.GA7078@linux-mips.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2006 16:43:22 +0100
Ladislav Michl <ladis@linux-mips.org> wrote:

> Hi,
> 
> this is DS1337 driver for RTC subsystem, tested on VoiceBlue board.
> Patch doesn't remove old driver, let's wait for some feedback...
> Please test it, so we do not miss next merge window :-)

 Hi,

  there's a similar patch that has been posted here (and probably
 merged in -mm) by David Brownell on 20050416. It should work with
 DS1307, 37 and 39. You might want to give it a look to see
 if it satisfies your needs.
 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

