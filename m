Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbVICI0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbVICI0r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbVICI0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:26:47 -0400
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:44809 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1161190AbVICI0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:26:46 -0400
Date: Sat, 3 Sep 2005 10:26:56 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: i2c via686a.c: save at least 0.5k of space by long v[256] ->
 u16 v[256]
Message-Id: <20050903102656.117e4dbe.khali@linux-fr.org>
In-Reply-To: <200509020854.37192.vda@ilport.com.ua>
References: <200509010910.14824.vda@ilport.com.ua>
	<20050901155915.GB1235@kroah.com>
	<200509020854.37192.vda@ilport.com.ua>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

BTW...

> Please be informed that there are lots of intNN_t's in i2c dir
> tho...

I couldn't find any. What were you refering to exactly?

Thanks,
-- 
Jean Delvare
