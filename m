Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVGVR7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVGVR7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 13:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVGVR7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 13:59:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29058 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261336AbVGVR7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 13:59:02 -0400
Subject: Re: Kernel cached memory
From: Lee Revell <rlrevell@joe-job.com>
To: lgb@lgb.hu
Cc: Ashley <ashleyz@alchip.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050722132523.GJ20995@vega.lgb.hu>
References: <003401c58ea2$4dfd76f0$5601010a@ashley>
	 <20050722132523.GJ20995@vega.lgb.hu>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 22 Jul 2005 13:58:59 -0400
Message-Id: <1122055139.877.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 15:25 +0200, Gábor Lénárt wrote:
> Anyway, want to have 'free memory' is a thing like having dozens of cars
> in your garage which don't want to be used ...
> 

Really?  I thought it was good to leave some memory free to speed up
application startup, so we don't have to evict a bunch of pages first.

Lee

