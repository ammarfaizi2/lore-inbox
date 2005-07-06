Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVGFT6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVGFT6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVGFT4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:56:16 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:56620 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262131AbVGFPft convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:35:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QKwMM9B3nsxJXPZGqc7usNG3AaEIq8iN4uVj3cOi/mnLMlSgTJUzX5mM3bojTG8zatc3i34nKjw09eNU/7eRQZhHRDf8wpLk3E6/dn1gAp12C9jdxx51Ulw/d3faV3UwQI5H8B7R3cdJCMHfFZYqiapkagx7Tah35hkhnw+KW5M=
Message-ID: <d4dc44d50507060835369099ea@mail.gmail.com>
Date: Wed, 6 Jul 2005 17:35:48 +0200
From: Schneelocke <schneelocke@gmail.com>
Reply-To: Schneelocke <schneelocke@gmail.com>
To: Rob Prowel <tempest766@yahoo.com>
Subject: Re: PROBLEM: please remove reserved word "new" from kernel headers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/05, Rob Prowel <tempest766@yahoo.com> wrote:
> 2.4 and 2.6 kernel headers use c++ reserved word "new"
> as identifier in function prototypes.
> [...]
> While not an error, per se, it is kind of sloppy and
> it is amazing that it hasn't shown up before now.
> using the identifier "new" in kernel headers that are
> visible to applications programs is a bad idea.

This has been discussed before: see
http://marc.theaimsgroup.com/?l=linux-kernel&m=111637766131104&w=2 and
the ensuing thread.

-- 
schnee
