Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVCPT2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVCPT2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVCPT2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:28:17 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3748 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262760AbVCPT2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:28:14 -0500
Subject: Re: Driver Development
From: Lee Revell <rlrevell@joe-job.com>
To: "shafa.hidee" <shafa.hidee@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00a701c52a0b$cec6f780$6a88cb0a@hss.hns.com>
References: <00a701c52a0b$cec6f780$6a88cb0a@hss.hns.com>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 14:28:12 -0500
Message-Id: <1111001293.21369.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-16 at 15:07 +0530, shafa.hidee wrote:
> Hi All,
>        Is there any driver development project going on where I can try
> apply driver development method.
> 

Of all the kernel subsystems ALSA presents one of the cleanest APIs for
driver writers.

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/

And there are several chipsets for which we have docs and no driver.

HTH,

Lee

