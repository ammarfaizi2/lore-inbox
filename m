Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWFWEzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWFWEzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 00:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWFWEzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 00:55:13 -0400
Received: from main.gmane.org ([80.91.229.2]:207 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932299AbWFWEzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 00:55:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Ryan M." <kubisuro@att.net>
Subject: Re: problem burning DVDs with 2.6.17-ck1 (mlockall?)
Date: Fri, 23 Jun 2006 13:55:12 +0900
Message-ID: <449B7430.80503@att.net>
References: <449B52BF.3070404@pcisys.net>
Reply-To: kubisuro@att.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 210.120.111.91
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
In-Reply-To: <449B52BF.3070404@pcisys.net>
Cc: ck@vds.kolivas.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Brian Hall wrote:
> After upgrading from 2.6.16-ck11 to 2.6.17-ck1, I find I can no longer
> burn DVDs. With growisofs I get:
<snip>
> Maybe it's something else I've done on the system. Running ~amd64 Gentoo
> 2006.0. Suggestions welcome!
> 

I have not had any problems burning DVDs with 2.6.17-ck1 using an ix86 kernel.

I primarily use k3b which utilizes growisofs.

Perhaps something else in kernel 2.6.17 with regards to x86-64 changed to cause this
problem?

regards,
Ryan M.

