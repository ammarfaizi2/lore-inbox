Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965334AbVKBXWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbVKBXWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965335AbVKBXWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:22:05 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:14309 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965334AbVKBXWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:22:04 -0500
Subject: Re: NTP broken with 2.6.14
From: john stultz <johnstul@us.ibm.com>
To: Jean-Christian de Rivaz <jc@eclis.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4369464B.6040707@eclis.ch>
References: <4369464B.6040707@eclis.ch>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 15:21:56 -0800
Message-Id: <1130973717.27168.504.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 00:05 +0100, Jean-Christian de Rivaz wrote:
> Since I have installed the new kernel 2.6.14, ntpd is unable to
> synchronize the time:

I'm working to see if I can reproduce this. Is this with 2.6.14 vanilla,
or from Linus' git tree post 2.6.14?

thanks
-john




