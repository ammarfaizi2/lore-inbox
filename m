Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTL2Qyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTL2Qyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:54:31 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:12722 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S263695AbTL2Qya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:54:30 -0500
Date: Mon, 29 Dec 2003 17:39:55 +0100
From: GCS <gcs@lsc.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm2
Message-ID: <20031229163955.GA20207@lsc.hu>
References: <20031229013223.75c531ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20031229013223.75c531ed.akpm@osdl.org>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 01:32:23AM -0800, Andrew Morton <akpm@osdl.org> wrote:
> . A couple of patches here should fix the CDROM-related problems which
>   some people saw in 2.6.0-mm1.
 Fixed for me.

> +input-mousedev-remove-jitter.patch
> +input-mousedev-ps2-emulation-fix.patch
> 
>  PS/2 mouse fixes.
 As previously noted, they do work. In result, -mm2 is just fine for me.

Thanks,
GCS
