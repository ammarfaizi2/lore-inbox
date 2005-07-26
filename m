Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVGZKnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVGZKnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVGZKnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:43:32 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:4742 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261665AbVGZKnb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:43:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hyYZKUlH7W+x2gfQX8+DbeG9NPmZvzdFPuJ7GaX0Q4S8fVmjdKkcbvAKTDFy335GPzdtHqnGVkzcr4+SBkrMKXelJfSi/Oc0pKpIu5tgySSvNZ3DZNro8Jpb+MZsk5narvvDlnGzwBnRR93TizqegAUmh0mGmSKhuLMYMhvyY0c=
Message-ID: <105c793f0507260343389ce2e4@mail.gmail.com>
Date: Tue, 26 Jul 2005 06:43:31 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Jaroslav Kysela <perex@suse.cz>
Subject: Re: BUG: Yamaha OPL3SA2 does not work with ALSA on 2.6 kernels.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <105c793f050726033672560fd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <105c793f05072507315cfd1878@mail.gmail.com>
	 <Pine.LNX.4.61.0507260828030.8190@tm8103-a.perex-int.cz>
	 <105c793f050726033672560fd4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/05, Andrew Haninger <ahaning@gmail.com> wrote:
> I'll report what I know in bug #879.
*Durr* I didn't scroll down. I've already reported my current
semi-working (works+oopses) setup in that bug report

I'm reporting this here now because of the part of that bug report
that suggests that it might actually be a kernel bug.

-Andy
