Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWE2Vpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWE2Vpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWE2Voy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:44:54 -0400
Received: from akl.day-one.co.nz ([210.54.239.78]:62689 "EHLO
	smtp.day-one.co.nz") by vger.kernel.org with ESMTP id S1751321AbWE2VXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:46 -0400
X-Antivirus-MYDOMAIN-Mail-From: chris.byrne@monstavision.com via smtp.day-one.co.nz
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(172.27.20.1):. Processed in 0.03182 secs Process 13398)
Message-ID: <447B6723.5070000@monstavision.com>
Date: Tue, 30 May 2006 09:26:59 +1200
From: Chris Byrne <chris.byrne@monstavision.com>
Reply-To: chris.byrne@monstavision.com
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: compile error: i2c_transfer
References: <200605292214.10378.toralf.foerster@gmx.de>
In-Reply-To: <200605292214.10378.toralf.foerster@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toralf Förster wrote:
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 

Try enabling I2C


