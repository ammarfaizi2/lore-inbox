Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVCOIwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVCOIwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 03:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVCOIwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 03:52:43 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:25097 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262344AbVCOIwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 03:52:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bHIGypLwdoopFBroz3/WzhigmD6bu5wLi3+4dn5XzYcYsYpT1GI7YpsAyUYJS7WAa14JyLlDzsQR0vu2vgO52O2Mc6lg3nqhcCIkLef+4zENw79QZQhf3CqWxbbmXMj70bzLiZ+jJgrz5cYGZIRYNnCihiC5CW26fMefiH0vUq0=
Message-ID: <3f250c7105031500527007a0e7@mail.gmail.com>
Date: Tue, 15 Mar 2005 04:52:21 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: oom with 2.6.11
Cc: linux-kernel <linux-kernel@vger.kernel.org>, elenstev@mesatop.com
In-Reply-To: <4231B4A4.4050207@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <422DC2F1.7020802@g-house.de>
	 <3f250c710503090518526d8b90@mail.gmail.com>
	 <3f250c7105030905415cab5192@mail.gmail.com>
	 <422F016A.2090107@g-house.de> <423063DB.40905@g-house.de>
	 <3f250c7105031101016d7cb08e@mail.gmail.com>
	 <4231B4A4.4050207@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Fri, 11 Mar 2005 16:09:24 +0100, Christian Kujau <evil@g-house.de> wrote:
> Mauricio Lin wrote:
> > Hi Christian,
> >
> > I would like to know what are the kernel versions this problem happened.
> >
> > Did this problem start from 2.6.11-rc2-bk10?
> 
> i noticed it first at 2.6.11, then again with 2.6.11-rc5-bk2. suspecting
> pppd to be the culprit to chew up all RAM after being terminated by my ISP
> once a day - i just have to wait (must be around 2a.m.).

Have you tried with 2.6.10 in order to check this problem?

BR,

Mauricio Lin.
