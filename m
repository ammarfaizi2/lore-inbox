Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbVLNCOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbVLNCOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbVLNCOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:14:32 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:31395 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030419AbVLNCOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:14:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>
Subject: Re: bugs?
Date: Tue, 13 Dec 2005 21:14:23 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, coywolf@gmail.com
References: <439F79CE.6040609@ens.etsmtl.ca>
In-Reply-To: <439F79CE.6040609@ens.etsmtl.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512132114.23496.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 20:47, Caroline GAUDREAU wrote:
> my cpu is 1400MHz, but why there's cpu MHz         : 598.593
>

Do you have cpufreq active?

[root@core ~]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III Mobile CPU      1000MHz
stepping        : 1
cpu MHz         : 730.646

-- 
Dmitry
