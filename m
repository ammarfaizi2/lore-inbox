Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287145AbSBGKNo>; Thu, 7 Feb 2002 05:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287141AbSBGKNe>; Thu, 7 Feb 2002 05:13:34 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:31104 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S287139AbSBGKNZ>;
	Thu, 7 Feb 2002 05:13:25 -0500
User-Agent: Microsoft-Entourage/10.0.0.1309
Date: Thu, 07 Feb 2002 05:14:03 -0500
Subject: Re: [ANNOUNCE] 2.4.18-pre8-mjc
From: Michael Cohen <lkml@ohdarn.net>
To: LKML <linux-kernel@vger.kernel.org>
Message-ID: <B887BD9B.3D6%lkml@ohdarn.net>
In-Reply-To: <012901c1afbe$be1b6d00$040010ac@LocalHost>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/02 5:03 AM, "Tarkan Erimer" <tarkane@solmaz.com.tr> wrote:

> Your patch list is very nice. Is there any chance to add XFS patch, also?

Shawn Starr has been working on this.

> If so, it would be wonderful for me and the others , I think, who uses XFS
> and want to use these patches, too. Because, if i patch my kernel with XFS,
> i can't add other patches, like yours.

Personally I think XFS ought to stay in fs/xfs already and stop encroaching
on the rest of the kernel.  It's also HUGE.  But hey, if Shawn wants to do
it, let him do it.

------
Michael Cohen

