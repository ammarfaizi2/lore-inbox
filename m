Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWHIRBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWHIRBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWHIRBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:01:54 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:30735 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751027AbWHIRBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:01:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YubFDa6Td8UBujWhZ8b+n8w9Z8lxDRLm+quVF0PH5WuKTBtldsOWURUjtk4oDt+a1jAWNvyekbNykCpCIR8m1gdQeUPvWnne8wnkBc6CzF3VebOojnV70LmFAYnbHaFSavhuU5mx/m81WHdq2nO/LmdChQXj2hoqDBykvtGwZC8=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Date: Wed, 9 Aug 2006 10:01:41 -0700
User-Agent: KMail/1.8.1
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mtosatti@redhat.com,
       marcelo@kvack.org
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200608040957.05034.benjamin.cherian.kernel@gmail.com> <20060804165550.GA26701@1wt.eu>
In-Reply-To: <20060804165550.GA26701@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091001.43570.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy,
Sorry I didn't notice your email till now.

On Friday 04 August 2006 09:55, Willy Tarreau wrote:
> The problem is that Marcelo is very very busy those days (as you might have
> noticed from the delay between each release), and there are a good bunch of
> security fixes in -rc3 which should wait too much in -rc. Maybe an -rc4
> would be OK, but I don't know if Marcelo has enough time to spend on yet
> another RC. Otherwise, if I produce a 2.4.34-pre1 about one week after
> 2.4.33, does that fit your needs ? I already have a few fixes waiting which
> might be worth a first pre-release.

It would be nice if you could do another rc, because otherwise it seems the 
patch wouldn't get into a stable kernel for a long time. But if it's really 
too much work for Marcelo, I would understand you putting it in th 2.4.34 
pre-release.

Thanks again,
Ben
