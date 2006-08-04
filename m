Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161302AbWHDQ5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161302AbWHDQ5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161303AbWHDQ5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:57:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:61022 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161302AbWHDQ5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:57:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bAoz3H9gaMlPqotsbZn3S4z1PG4kGy7ew3uLKDyLPVtd3jjoAk5cEq7RZAz8XitaIW7GXGzx7yrEfMVbSbDiZbXQX/y8gXBJDcbdnHzdyRhJevLhNZJc2M2BkCBPqg56ABlUfPm/f9+IklGaxxbC+VW58niocqAEb5naGw877Ow=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Date: Fri, 4 Aug 2006 09:57:04 -0700
User-Agent: KMail/1.8.1
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <20060802230058.0ff73025.zaitcev@redhat.com> <20060803062903.GA19176@1wt.eu>
In-Reply-To: <20060803062903.GA19176@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608040957.05034.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy,

On Wednesday 02 August 2006 23:29, Willy Tarreau wrote:
> Perfect. Patch queued, thanks Pete.

Do you know if it would be possible for this to get into 2.4.33? I know its 
already at rc3, but it would be nice if this patch could be pushed out sooner 
since 2.4.34 will probably not be out for a while. I would really appreciate 
it. Thanks to both you and Pete for your help.

Ben
