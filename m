Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273432AbRINRMo>; Fri, 14 Sep 2001 13:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273433AbRINRMf>; Fri, 14 Sep 2001 13:12:35 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49904
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273432AbRINRM0>; Fri, 14 Sep 2001 13:12:26 -0400
Date: Fri, 14 Sep 2001 10:12:37 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx errors in 2.2.19 but not in 2.2.18
Message-ID: <20010914101237.B2535@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BA2021F.488F65F8@t-online.de> <Pine.LNX.4.30.0109141523190.27057-100000@talentix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109141523190.27057-100000@talentix.dwd.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2001 at 03:46:10PM +0200, Holger Kiehl wrote:
> I have played with 2.4.5 and the new aic7xxx driver and did not see
> the problems here. Have not tried the old one under 2.4.5. Unfortunately
> I cannot take 2.4.x because of the bigger swap demand.
> 
2.4.x-ac doesn't have the high swap requirement.  Swap demands look similar
to 2.2.xx kernels with 2.4.{8,9}-ac.
