Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTJNK3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTJNK3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:29:32 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:11439 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262319AbTJNK3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:29:31 -0400
To: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.7TH 0.4]Thoughts
References: <S262101AbTJNKCK/20031014100210Z+13761@vger.kernel.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 14 Oct 2003 12:29:18 +0200
In-Reply-To: <S262101AbTJNKCK/20031014100210Z+13761@vger.kernel.org>
Message-ID: <m3he2c2jup.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<ffrederick@prov-liege.be> writes:

> Already in:
> 
> * Software RAID 0+1 perhaps?
>                 A lot of hardware RAID cards support it, why not the
>                 kernel?  By RAID 0+1 I mean mirror-RAIDing two (or more)
>                 stripe-RAID arrays.  (Or can this be done already?)

I think so. And better: stripe-RAIDing two or more mirror-RAIDs.
-- 
Krzysztof Halasa, B*FH
