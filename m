Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967527AbWK2Sbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967527AbWK2Sbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 13:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967528AbWK2Sbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 13:31:41 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:40925 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP id S967527AbWK2Sbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 13:31:40 -0500
Message-ID: <456DD1D1.50007@web.de>
Date: Wed, 29 Nov 2006 19:30:41 +0100
From: Peter Schlaf <peter.schlaf@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.0.8) Gecko/20060911 SUSE/1.0.6-0.1 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Pauline Middelink <middelink@polyware.nl>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove the broken VIDEO_ZR36120 driver
References: <20061125191510.GB3702@stusta.de> <456BC973.1050309@feise.com> <20061128060723.GA15364@stusta.de> <456BD8E4.6010003@feise.com> <1164707859.12613.7.camel@localhost> <456C89E7.9010507@web.de> <20061128213808.GA25754@polyware.nl>
In-Reply-To: <20061128213808.GA25754@polyware.nl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pauline Middelink schrieb:
> On Tue, 28 Nov 2006 around 20:11:35 +0100, Peter Schlaf wrote:
>> Hello,
>>
>> I would like to see this driver fixed and remaining in the kernel and
>> would give any support I can to achive this goal.
>>
>> I have a zr36120 based tv card and wrote a driver on my own based on
>> this kernel driver from Pauline Middelink. Maybe it could be helpful.
> 
> I would have no problem Peter taking over the maintainance of the driver.
> Due to timeconstrains I no longer have the time to upgrade the driver
> to v4l2 (which is a bigger problem than getting the current driver to 
> run under 2.6)

Hi,

I can maintain the driver, if there is no objection.

But this driver only, not the bigphysarea patch.

CU
Peter
