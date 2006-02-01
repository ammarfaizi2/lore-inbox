Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWBAK7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWBAK7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWBAK7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:59:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:8617 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932421AbWBAK7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:59:14 -0500
Message-ID: <43E09480.90405@suse.de>
Date: Wed, 01 Feb 2006 11:59:12 +0100
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Re: 2.6.16-rc1-mm4
References: <20060129144533.128af741.akpm@osdl.org>	 <20060201001940.GM16557@redhat.com>	 <20060201005930.GR16557@redhat.com> <200602011138.38065.trenn@suse.de> <3aa654a40602010251t2c5d8acdt85f2d85af5ef9f89@mail.gmail.com>
In-Reply-To: <3aa654a40602010251t2c5d8acdt85f2d85af5ef9f89@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich wrote:
> 
> Applied those two patches you just put in this list by hand to -mm4.
> Works fine, thanks for the quick resonse.
> 
> --
What cpufreq driver are you using?
The driver itself should already have set policy->cur in its
init function.

   Thomas
