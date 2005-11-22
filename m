Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVKVEAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVKVEAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 23:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVKVEAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 23:00:11 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13253 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932083AbVKVEAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 23:00:10 -0500
Subject: Re: virtual OSS devices [for making selfish apps happy]
From: Lee Revell <rlrevell@joe-job.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Christian Parpart <trapni@gentoo.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200511220226.48074.s0348365@sms.ed.ac.uk>
References: <200511212216.10837.trapni@gentoo.org>
	 <1132609221.29178.93.camel@mindpipe>
	 <200511220226.48074.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 22:59:59 -0500
Message-Id: <1132631999.4772.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 02:26 +0000, Alistair John Strachan wrote:
> Which it already has been, for literally years.
> 
> [alistair] 02:26 [~] artsd -A
> possible choices for the audio i/o method:
> 
>   toss      Threaded Open Sound System
>   null      No Audio Input/Output
>   alsa      Advanced Linux Sound Architecture
>   oss       Open Sound System
> 

Unfortunately it still seems to default to OSS on many systems.

Lee

