Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWE3SdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWE3SdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWE3SdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:33:04 -0400
Received: from mx0.towertech.it ([213.215.222.73]:58251 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932378AbWE3SdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:33:03 -0400
Date: Tue, 30 May 2006 20:32:41 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Raphael Assenat <raph@raphnet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add max6902 RTC support
Message-ID: <20060530203241.4a4de734@inspiron>
In-Reply-To: <20060530150913.GE797@aramis.lan.raphnet.net>
References: <20060530150913.GE797@aramis.lan.raphnet.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 11:09:14 -0400
Raphael Assenat <raph@raphnet.net> wrote:

> +//#define RTC_DEBUG

 Please remove it or use #undef
(and maybe rename it to MAX6902_DEBUG :) )

 The driver seems fine to me, you may
 want to send it to Andrew for inclusion
 in -mm.

 thanks!


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

