Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWJJO7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWJJO7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWJJO7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:59:16 -0400
Received: from mail-sin.bigfish.com ([207.46.51.74]:5739 "EHLO
	mail7-sin-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932125AbWJJO7P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:59:15 -0400
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: cpufreq not working on AMD K8 (was Re: 2.6.19-rc1: known
 regressions)
Date: Tue, 10 Oct 2006 09:59:04 -0500
Message-ID: <1449F58C868D8D4E9C72945771150BDF1536ED@SAUSEXMB1.amd.com>
In-Reply-To: <200610101418.27549.christiand59@web.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq not working on AMD K8 (was Re: 2.6.19-rc1: known
 regressions)
Thread-Index: AcbsZm6SZEBDWlVjQK6F/A5HK9NulwAFgcBA
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Christian" <christiand59@web.de>, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 10 Oct 2006 14:59:04.0656 (UTC)
 FILETIME=[A0EC0500:01C6EC7C]
X-WSS-ID: 69356AB21L85478334-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an AMD K8 system and I'm unable to get cpufreq working 
> with 2.6.19-rc1. 
> The cpufreq sysfs directory is missing under 
> /sys/devices/system/cpu/cpu0/. 
> 2.6.18 works as expected.

What error message are you getting from `dmesg | grep power` ?

I didn't make any changes to powernow-k8 for 2.6.19 so I'm
surprised you found a regression.

-Mark Langsdorf
AMD, Inc.


