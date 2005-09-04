Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVIDRHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVIDRHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVIDRHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:07:44 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:35736 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932068AbVIDRHn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:07:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AkRb5oVEaspV8glMp+pahrrGK3zOd0BvBSAdUtu7fdNvEgBBy3/zGkk8zm6BE/TZcsV630oBBEhQ7TJQzXwWYb+5fhPMhOgEAmJdYayYU6NJLMsc0oPXqhM426zhCOpUDMD1OvVm4gx9UJiTBXOIAZplXTepQBGg2tiP7wRRvR4=
Message-ID: <84144f02050904100721d3844d@mail.gmail.com>
Date: Sun, 4 Sep 2005 20:07:41 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paul Misner <paul@misner.org>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509041144.13145.paul@misner.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com>
	 <200509041549.17512.vda@ilport.com.ua>
	 <200509041144.13145.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Paul Misner <paul@misner.org> wrote:
> No one is asking you to 'care' about our problems running a notebook with a
> closed source driver under ndiswrapper.  

Yes you are. You're asking for 4KSTACKS config option to maintained
and it is not something you get for free. Besides, if it is indeed
ripped out of mainline kernel, you can always keep it a separate patch
for ndiswrapper.

                                      Pekka
