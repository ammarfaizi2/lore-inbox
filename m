Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWAMM6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWAMM6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWAMM6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:58:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52612 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422651AbWAMM6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:58:21 -0500
Date: Fri, 13 Jan 2006 13:58:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/13] s390: des crypto code cleanup.
Message-ID: <20060113125808.GA1868@elf.ucw.cz>
References: <20060112171404.GB16629@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060112171404.GB16629@skybase.boeblingen.de.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 12-01-06 18:14:04, Martin Schwidefsky wrote:
> From: Jan Glauber <jan.glauber@de.ibm.com>
> 
> [patch 1/13] s390: des crypto code cleanup.
> 
> Beautify the s390 in-kernel-crypto des code.
> 
> Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Why does s390 need to do des in arch-specific code, BTW? Is it driver
for some crypto accelerator or what?
							Pavel


-- 
Thanks, Sharp!
