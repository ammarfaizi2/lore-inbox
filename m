Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVGSDOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVGSDOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 23:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVGSDOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 23:14:40 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:15805 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261361AbVGSDOj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 23:14:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tEQ8JFkJ+A+dSDt26wp+z+8pST1Sp2yKnJLifXEQGV3nlplH7zOY0wDCnUN2+0hyNP8CQkzG+lmVwvkZN8pvhUnZSZDkz9b5v442S39Vj0V3y2FS4W3OcQm+mmhrx5INhfxKdu63PE8PccWnPMHX909oNcyhQwQnWSOCQ714/eA=
Message-ID: <1e62d13705071820132e7fa6c9@mail.gmail.com>
Date: Tue, 19 Jul 2005 08:13:29 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: Keith Owens <kaos@sgi.com>
Subject: Re: Regarding KDB for REDHAT9.0
Cc: Subbu <subbu@sasken.com>, linux-kernel@vger.kernel.org,
       subbu2k_av@yahoo.com
In-Reply-To: <5276.1121737277@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.GSO.4.30.0507181124560.28721-100000@sunrnd2.sasken.com>
	 <5276.1121737277@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/05, Keith Owens <kaos@sgi.com> wrote:
> 
> Sorry, not available.  RedHat do not want kdb so SGI do not do KDB
> patches against RedHat distributions.  Use SuSE instead, that has KDB
> built in.
> 

I want to add one more thing, you can compile your own kernel with KDB
patch applied .... if u really want to use KDB on Redhat ...... And I
think you can also try to apply patch of KDB for 2.4.20 on the Redhat
kenel, that might succeed if redhat havn't changed anything in the
files of 2.4.20 kernel in which KDB patches or make changes .........


-- 
Fawad Lateef
