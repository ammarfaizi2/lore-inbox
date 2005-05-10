Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVEJU2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVEJU2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVEJU2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:28:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44440 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261774AbVEJU20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:28:26 -0400
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <gregkh@suse.de>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050510201355.GB3226@suse.de>
References: <20050506212227.GA24066@kroah.com>
	 <1115611034.14447.11.camel@localhost.localdomain>
	 <20050509232103.GA24238@suse.de>
	 <1115717357.10222.1.camel@localhost.localdomain>
	 <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru>
	 <20050510172447.GA11263@wonderland.linux.it>
	 <20050510201355.GB3226@suse.de>
Content-Type: text/plain
Date: Tue, 10 May 2005 16:28:24 -0400
Message-Id: <1115756904.14061.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 13:13 -0700, Greg KH wrote:
> Also, the blacklisting stuff should not be
> that prevelant anymore...

It's quite often used by ALSA users who need to prevent hotplug from
loading the OSS modules.  Is there a better way to do this?

Lee

