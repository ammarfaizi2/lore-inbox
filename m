Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUAMN7C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 08:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbUAMN7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 08:59:01 -0500
Received: from kiy.wanderer.org ([195.218.87.138]:39953 "EHLO kiy.wanderer.org")
	by vger.kernel.org with ESMTP id S264308AbUAMN7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 08:59:00 -0500
Message-ID: <4003F998.4020104@tv.debian.net>
Date: Tue, 13 Jan 2004 15:58:48 +0200
From: Tommi Virtanen <tv@tv.debian.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lorenzo Hernandez Garcia-Hierro <lorenzohgh@nsrg-security.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Noise with  2.6.0 in a Dell Laptop ( Latitude c600 )
References: <1073488405.850.35.camel@zeus>
In-Reply-To: <1073488405.850.35.camel@zeus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Hernandez Garcia-Hierro wrote:
> When the 2.6.0 inits in my laptop it becomes reaaallyyy noisy.
> Why ?

If it's the fans, it's the BIOS reading CPU temperature of 85 C,
which is not true. It seems a Fn-Z press resets this reading to
sane values. You can look at the temperature reading and fan
state with i8kutils.

Atleast that's what a Dell Latitude C640 that I had did.

