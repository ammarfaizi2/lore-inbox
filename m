Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUADIy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 03:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbUADIy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 03:54:26 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:31010 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S264954AbUADIyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 03:54:25 -0500
Message-Id: <5.1.0.14.2.20040104195316.02151e98@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 04 Jan 2004 19:54:14 +1100
To: Soeren Sonnenburg <kernel@nn7.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Cc: Con Kolivas <kernel@kolivas.org>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
In-Reply-To: <1073203762.9851.394.camel@localhost>
References: <200401041242.47410.kernel@kolivas.org>
 <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
 <200401040815.54655.kernel@kolivas.org>
 <20040103233518.GE3728@alpha.home.local>
 <200401041242.47410.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:09 PM 4/01/2004, Soeren Sonnenburg wrote:
[..]
>Looking at that how can it not be a scheduling problem ....

out of interest, have you tried to see how 2.4.xx compares when compiled 
with HZ set to 1000?
(or conversely, 2.6 compiled with HZ set to 100)


cheers,

lincoln.

