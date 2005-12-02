Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVLBDWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVLBDWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 22:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVLBDWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 22:22:54 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:46171 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964822AbVLBDWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 22:22:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qy427j2pg6r4pYuqdRuDE71yP2mqtfX5WfiFkT6f71mTC6FsdeROAYRVga3aD1ZwqXrSC3BiRS6KdmQUJhBusbNgwpZRZ+2L4di+mlao2vXCNZupjGgMak/reLrP5829B35Mwg4PXOIMjgz28uhPCuL4YAG9AFlHZ6zDh8uvgi4=
Message-ID: <2cd57c900512011922s472b8692q@mail.gmail.com>
Date: Fri, 2 Dec 2005 11:22:51 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: keep in sync with -mm tree?
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051107191521.0217a60b.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cd57c900511071835le734f8do@mail.gmail.com>
	 <20051107185028.137a94eb.akpm@osdl.org>
	 <20051107191521.0217a60b.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/8, Paul Jackson <pj@sgi.com>:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/
>
> Cool - thanks.

I find that it is something being there when we don't need, and
missing when we do need. I suggest to let users pull from instead of
akpm push it there. It's a script invoked by users.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
