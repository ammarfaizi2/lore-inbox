Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUFFUFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUFFUFo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 16:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUFFUFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 16:05:44 -0400
Received: from spectre.fbab.net ([212.214.165.139]:27884 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S264101AbUFFUFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 16:05:40 -0400
Message-ID: <40C378ED.5050300@fbab.net>
Date: Sun, 06 Jun 2004 22:05:01 +0200
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux crashing on amd athlons?
References: <001701c44bf7$c8991f20$0200a8c0@laptop> <yw1xhdtov5wf.fsf@kth.se>
In-Reply-To: <yw1xhdtov5wf.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> "Ameer Armaly" <ameer@charter.net> writes:
> 
> 
>>Hi all.
>>While installing linux on an amd athlon, the kernel is oopsing and shuting
>>down the computer at random places  within the install.  This is a custom
>>built kernel off of kernel.org I built, which I optimized for athlon then
>>i386 afterwards, but with no luck.
> 
> 
> Bad memory maybe.
> 

Another tip with Athlons is to make sure that you have a good 
powersupply. We have had some random crashes with a fileserver using 
dual Athlons, and it turned out to be underpowered due to the disks 
taking too much juice...

Regards
Magnus


