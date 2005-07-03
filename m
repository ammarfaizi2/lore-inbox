Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVGCPIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVGCPIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 11:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVGCPIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 11:08:09 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:53260 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261454AbVGCPIF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:08:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ic399F012ogvLQaeOAgI5VULJc+346MCaLCtZt6kpIiaiRltMjdc1ToLSsW558jFnbHQP9hVL1ePUaqhi9atmhxdDZc4XNWvsOOLgwYPp7wVs0IhV23GB/wVi2F9wRnAlrE3854pGd+OcgS4mejvTrZ5/gMdKB2O4bRow5/JpJg=
Message-ID: <9e473391050703080877d7cbde@mail.gmail.com>
Date: Sun, 3 Jul 2005 11:08:05 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
Subject: Re: [ANNOUNCE] ORT - Oops Reporting Tool v.b4
Cc: linux-kernel@vger.kernel.org,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Paul TT <paultt@bilug.linux.it>, randy_dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, cp@absolutedigital.net
In-Reply-To: <42C7FBD3.1020002@trex.wsi.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42C7FBD3.1020002@trex.wsi.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you make a script that takes an OOPS and finds the right line in
the kernel source? I can never remember how to make the kernel build
system generate mixed C/ASM output for a specific file.

-- 
Jon Smirl
jonsmirl@gmail.com
