Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWBZUnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWBZUnE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWBZUnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:43:04 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:38324 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751145AbWBZUnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:43:03 -0500
Subject: Re: Building 100 kernels; we suck at dependencies and drown in
	warnings
From: Lee Revell <rlrevell@joe-job.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <200602261721.17373.jesper.juhl@gmail.com>
References: <200602261721.17373.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 15:42:58 -0500
Message-Id: <1140986578.24141.141.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 17:21 +0100, Jesper Juhl wrote:
> Hi everyone,
> 
> I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)

What GCC version?  4.x still has the bug where it spews false warnings
about things being used uninitialized.

Lee

