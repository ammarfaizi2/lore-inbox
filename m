Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751861AbWJWJjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbWJWJjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 05:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbWJWJjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 05:39:49 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:36833 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S1751861AbWJWJjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 05:39:49 -0400
Message-ID: <453C8DDB.6090003@stud.feec.vutbr.cz>
Date: Mon, 23 Oct 2006 11:39:39 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Giridhar Pemmasani <pgiri@yahoo.com>
CC: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
References: <20061023064114.49794.qmail@web32403.mail.mud.yahoo.com>
In-Reply-To: <20061023064114.49794.qmail@web32403.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.177 () FROM_ENDS_IN_NUMS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giridhar Pemmasani wrote:
> --- Chase Venters <chase.venters@clientec.com> wrote:
>> Are there even any examples of GPL-licensed NDIS drivers?
> 
> I don't remember off hand, but sometime back there was discussion on related
> topic of weather ndiswrapper should be in debian-main or not, and someone
> pointed out a GPL ndis driver. (BTW, after much discussion on debian devel
> list, the developers agreed that ndiswrapper belongs in debian-main.)

AFAIK, the only given example of a free NDIS driver was CIPE-Win32, 
which is a port of CIPE from Linux to Windows. It's quite pointless to 
use ndiswrapper for that.

Michal

