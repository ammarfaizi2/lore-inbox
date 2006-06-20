Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWFTRCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWFTRCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWFTRCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:02:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:29241 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751415AbWFTRCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:02:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FjtFQbsgJ04ppfj2+d1y/Ml8SqYnoXC8cPtZbpOAgY88VIBm+8yU/EjpPYoBiKtzCEPkP3itm3wnTV/aLahbaoRR53x4xjZit/gre0Pn/YdiCgxTSSHSqmAILHEtTJlZSMnxSUVRqXWoalJJf7HviSY5dsowO8eqQkWP5VOvK1w=
Message-ID: <3aa654a40606201001s40fc2bf3j27cd7cb555b02688@mail.gmail.com>
Date: Tue, 20 Jun 2006 10:01:59 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Cc: "Nathan Scott" <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
In-Reply-To: <Pine.LNX.4.64.0606200456540.3182@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com>
	 <20060620161006.C1079661@wobbly.melbourne.sgi.com>
	 <3aa654a40606192340l67d0353fj875767d33d8bd493@mail.gmail.com>
	 <Pine.LNX.4.64.0606200456540.3182@p34.internal.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> Have you checked to make sure you don't have a bad disk?

In the initial email I do state that I have run badblocks on this disk
sucessfully.
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
