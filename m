Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVE2ARG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVE2ARG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 20:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVE2ARG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 20:17:06 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:948 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261222AbVE2ARE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 20:17:04 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How to find if BIOS has already enabled the device
Date: Sat, 28 May 2005 20:17:07 -0400
User-Agent: KMail/1.8
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       John Livingston <jujutama@comcast.net>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com> <200505281301.09911.kernel-stuff@comcast.net> <1117325172.5423.102.camel@mindpipe>
In-Reply-To: <1117325172.5423.102.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505282017.08204.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 May 2005 20:06, Lee Revell wrote:
> devfs is not maintained and is listed as deprecated.  You'd be better
> off using udev.

Yep, that's on my list of things to do - I tried once to switch to udev but 
it's not the  "just works" type - atleast on Gentoo! 

-- 
