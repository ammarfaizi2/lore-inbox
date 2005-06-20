Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVFUACG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVFUACG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVFUAB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:01:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:46528 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261825AbVFTXbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:31:31 -0400
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
From: Lee Revell <rlrevell@joe-job.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
In-Reply-To: <42B73BB7.4030906@linuxwireless.org>
References: <007301c575d9$77decb90$600cc60a@amer.sykes.com>
	 <1119303358.17380.0.camel@mindpipe>  <42B73BB7.4030906@linuxwireless.org>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 19:35:00 -0400
Message-Id: <1119310501.17602.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1On Mon, 2005-06-20 at 16:57 -0500, Alejandro Bonilla wrote:
> Lenz Grimmer,
> 
> I'm trying to do watch -n1 cat /proc/acpi/ibm/ecdump, But I don't have 
> ecdump. I'm with ibm-acpi 0.8
> 

I was thinking more along the lines of figure out the io port it's
using, then boot windows, set an IO breakpoint in softice, then drop
your laptop on the bed or something.

Lee

