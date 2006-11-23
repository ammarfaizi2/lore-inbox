Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbWKWAli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWKWAli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 19:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757243AbWKWAlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 19:41:18 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:30035 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1757242AbWKWAlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 19:41:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=ZaKAhxCDbqXXl/HSI4u1D8BReAXvKS7BHndJAFqlorcqjIpuVOXplFCg/kkkpafqb7RdkVPRLuBvenrlDS0CLr9d/unS1fsq3wG01t3WELnUSYhpVwHpFwiRmpP14/oxdRVRW+863rGREJxG7LsCLNkZKMHH6Sdy1ahb2uIMaDk=  ;
X-YMail-OSG: seQFCzEVM1mR1pfz_XXTRbH9vNmpI6ile4YRgF9Qa1zeTs3R.opn6kGBfPPlCnaRbwBWnURuRRrUzay3higpmBjpalDxud8I0Q5hzUXIwbhH5VZNZhma
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [patch 2.6.19-rc6 1/6] rtc class /proc/driver/rtc update
Date: Wed, 22 Nov 2006 16:39:33 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <200611201014.41980.david-b@pacbell.net> <200611201847.58135.david-b@pacbell.net> <20061122213724.51c3e591@inspiron>
In-Reply-To: <20061122213724.51c3e591@inspiron>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611221639.34377.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 November 2006 12:37 pm, Alessandro Zummo wrote:
> 
>  given the experimental status, I'm inclined to remove the /proc
>  driver right now.

I actually prefer the /proc/driver/rtc* file to the sysfs stuff.
Even though some people would call that "politically incorrect".

- Dave
