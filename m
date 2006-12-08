Return-Path: <linux-kernel-owner+w=401wt.eu-S1760735AbWLHOLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760735AbWLHOLp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760738AbWLHOLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:11:45 -0500
Received: from mx0.towertech.it ([213.215.222.73]:52434 "HELO mx0.towertech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760735AbWLHOLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:11:44 -0500
Date: Fri, 8 Dec 2006 15:06:00 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [patch 2.6.19-git] RTC Kconfig sorted by type
Message-ID: <20061208150600.151861a1@inspiron>
In-Reply-To: <200612061652.45242.david-b@pacbell.net>
References: <200612061652.45242.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 16:52:44 -0800
David Brownell <david-b@pacbell.net> wrote:

> This reorders the RTC driver menu into separate sections, splitting out
> the SOC, I2C, and SPI support to help make the menu easier to navigate.
> (We got some feedback a while ago that it was "a mess" and hard to make
> sense of...)
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

 Thanks David, I was planning to do that myself.. you saved
 me some work! :)

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>
-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

