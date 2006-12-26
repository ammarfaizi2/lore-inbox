Return-Path: <linux-kernel-owner+w=401wt.eu-S1754621AbWLZAzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbWLZAzw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 19:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbWLZAzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 19:55:52 -0500
Received: from smtp-out.google.com ([216.239.33.17]:40170 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbWLZAzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 19:55:51 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=u4TVNUsiSgGV6fRa+3O4W5HO8rHcGJh865XzAO7ubI/ZUq1AvccFw43vqTAFbmgEM
	8jHC3Ht0R/cuFgEAF7mqw==
Message-ID: <6599ad830612251654w29deb6a8oc2e808ce356e07f8@mail.gmail.com>
Date: Mon, 25 Dec 2006 16:54:13 -0800
From: "Paul Menage" <menage@google.com>
To: "Kirill Korotaev" <dev@sw.ru>
Subject: Re: [PATCH 6/6] containers: BeanCounters over generic process containers
Cc: "Herbert Poetzl" <herbert@13thfloor.at>, akpm@osdl.org, pj@sgi.com,
       sekharan@us.ibm.com, xemul@sw.ru, serue@us.ibm.com, vatsa@in.ibm.com,
       rohitseth@google.com, winget@google.com, containers@lists.osdl.org,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <458FA510.3040104@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222141442.753211763@menage.corp.google.com>
	 <20061222145217.107513155@menage.corp.google.com>
	 <20061223194955.GA30764@MAIL.13thfloor.at> <458FA510.3040104@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/06, Kirill Korotaev <dev@sw.ru> wrote:
> > also note that certain limits are much more
> > complicated than the (very simple) file limits
> > and the code will be called at higher frequency
> Agree with this. This patch doesn't prove that BCs can be integrated to the
> containers infrastructure.

What concerns do you have in particular? Are there any changes that
you'd like to see?

Paul
