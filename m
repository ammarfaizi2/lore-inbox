Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267620AbTALXBA>; Sun, 12 Jan 2003 18:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267626AbTALXA7>; Sun, 12 Jan 2003 18:00:59 -0500
Received: from havoc.daloft.com ([64.213.145.173]:13276 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267620AbTALXAo>;
	Sun, 12 Jan 2003 18:00:44 -0500
Date: Sun, 12 Jan 2003 18:09:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
Message-ID: <20030112230927.GA9985@gtf.org>
References: <20030112220741.GA15849@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030112220741.GA15849@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it looks good, and since we're already pre-processing foo.S
files anyway...
