Return-Path: <linux-kernel-owner+w=401wt.eu-S1753643AbWLRJjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbWLRJjK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbWLRJjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:39:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:60589 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbWLRJjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:39:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JXABxZqQiQ1kDZDVFmJhhbBMmmzrcvrpcAoxB2aVT6RSJEOR2HYrE+HTCyVu8u0iAoTIBILbHkatOvNR0v/qS5ksZyKKs09L8OwUAvwT8rcQRC+RuD9EiWOmFpyPBGRLP0vU+aQMIF75cbJ+cjt8Zq+4C6GVi0wvjhnfgH+fRdQ=
Message-ID: <3efb10970612180139n5b18c3eam3b76af82e21c4194@mail.gmail.com>
Date: Mon, 18 Dec 2006 10:39:06 +0100
From: "Remy Bohmer" <l.pinguin@gmail.com>
Reply-To: linux@bohmer.net
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [BUG] 2.6.19-rt14 does not compile with CONFIG_NO_HZ
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061216075800.GB16116@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3efb10970612150606p643f7cffr6b93e857843abed6@mail.gmail.com>
	 <20061216075800.GB16116@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

-rt15 is indeed better...
Thanks!

Remy

2006/12/16, Ingo Molnar <mingo@elte.hu>:
>
> * Remy Bohmer <l.pinguin@gmail.com> wrote:
>
> > Hello,
> >
> > For your Information, I get the following compile error when
> > CONFIG_NO_HZ is NOT configured on 2.6.19.1-rt14:
>
> does -rt15 work any better?
>
>         Ingo
>
>
