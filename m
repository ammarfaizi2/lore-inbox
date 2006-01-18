Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWARK4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWARK4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWARK4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:56:03 -0500
Received: from mail.gmx.net ([213.165.64.21]:42144 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030208AbWARK4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:56:01 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm1
Date: Wed, 18 Jan 2006 11:55:59 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20060118005053.118f1abc.akpm@osdl.org>
In-Reply-To: <20060118005053.118f1abc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181155.59843.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 18. January 2006 09:50, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.
>6.16-rc1-mm1/

  LD      .tmp_vmlinux1
sound/built-in.o:(__ksymtab+0x670): undefined reference to 
`snd_pcm_format_name'
make: *** [.tmp_vmlinux1] Fehler 1

If needed, I can provide my config as well.

hth,
dominik
