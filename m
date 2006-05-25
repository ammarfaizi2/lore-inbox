Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbWEYW30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbWEYW30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWEYW30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:29:26 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37255 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030486AbWEYW30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:29:26 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Lee Revell <rlrevell@joe-job.com>
To: devmazumdar <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e55715+usls@eGroups.com>
References: <e55715+usls@eGroups.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 18:29:22 -0400
Message-Id: <1148596163.31038.30.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 21:19 +0000, devmazumdar wrote:
> How does one check the existence of the kernel source RPM (or deb) on
> every single distribution?.
> 
> We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> SuSE, Mandrake and CentOS - how about other RPM based distros? How
> about debian based distros?. There doesn't seem to be a a single
> conherent naming scheme.  

I'd really like to see a distro-agnostic way to retrieve the kernel
configuration.  /proc/config.gz has existed for soem time but many
distros inexplicably don't enable it.

Lee

