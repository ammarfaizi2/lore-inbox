Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWCWNnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWCWNnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCWNnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:43:04 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:46832 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751224AbWCWNnD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:43:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c5fXJq8KPL04xXNjFGAzDg8WIZ8m/tv1HR6jYOBQcnj3R9bm55WvQUF1D/rWixcNFfJIzXILj8FijxGOgr6IFIaG1AVGt4RIFPV9/MpHGSJJKQWdjSA0QB76PVJibtGlVP3XkHFDkLHDMg2WfI+boBPP3iBgKR9q7EzD8o+z894=
Message-ID: <6bffcb0e0603230543p5351eff9u@mail.gmail.com>
Date: Thu, 23 Mar 2006 14:43:01 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: -mm merge plans
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060322205305.0604f49b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060322205305.0604f49b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/03/06, Andrew Morton <akpm@osdl.org> wrote:
>
> A look at the -mm lineup for 2.6.17:
>
[snip]
>
> oops-reporting-tool.patch
>
>   Might drop this.  Is it useful?
>

Probably only I use this. Please drop this patch.

(Here is a new version
www.stardust.webpages.pl/files/ort/ort-ltg1b.tar.bz2 , if someone like
it)

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
