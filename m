Return-Path: <linux-kernel-owner+w=401wt.eu-S1161130AbXAMAiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbXAMAiK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbXAMAiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:38:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:30609 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030474AbXAMAiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:38:08 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RCnBZ4YYIksNxMgnCqZeLQI+3kDW4SRwFtW3aZygKwud3YsCBg4+uMgjkTOOVcNCaSYD0PgsV8Dq1prOrlKLa1Nii2C0mFUEQ13BgiaUSKRZz5H1zDv8zVTMZFwOf0NtqSZ2XjAO0zvhxuTnDN6U0fYE9eBHsHnedg4bw2JEirk=
Date: Sat, 13 Jan 2007 03:38:05 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: list_del corruption with fedora 6 kernels (fc5 was ok)
Message-ID: <20070113003805.GA7283@martell.zuzino.mipt.ru>
References: <20070112233400.GA17470@wszip-kinigka.euro.med.ge.com> <1168648050.3579.45.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168648050.3579.45.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 07:27:30PM -0500, Lee Revell wrote:
> On Sat, 2007-01-13 at 00:34 +0100, Karl Kiniger wrote:
> > how to track this down?
>
> Reproduce it with an untainted kernel (no nvidia or vmware modules) and
> repost.

How about big fat advice in every tainted oops to bugger off?

