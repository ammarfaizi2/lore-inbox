Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWCYI2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWCYI2z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 03:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWCYI2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 03:28:55 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:45987 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751107AbWCYI2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 03:28:54 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [ck] [benchmark] Interbench 2.6.16-ck/mm
Date: Sat, 25 Mar 2006 19:28:38 +1100
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org,
       "=?iso-8859-1?q?Andr=E9_Goddard?= Rosa" <andre.goddard@gmail.com>,
       linux list <linux-kernel@vger.kernel.org>
References: <200603251351.57341.kernel@kolivas.org> <200603251501.32592.kernel@kolivas.org> <200603250921.32409.astralstorm@gorzow.mm.pl>
In-Reply-To: <200603250921.32409.astralstorm@gorzow.mm.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603251928.39190.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 March 2006 19:21, Radoslaw Szkodzinski wrote:
> On Saturday 25 March 2006 05:01, Con Kolivas wrote yet:
> > I don't expect that staircase will be better in every single situation.
> > However it will be better more often, especially when it counts (like
> > audio or video skipping) and far more predictable. All that in 300 lines
> > less code :)
>
> I thinks the main difference is those other scheduler improvements.
> Some of them are compatible with staircase.
> Could you also try a mixed and matched 2.6.16-ck1+mm?

You're kidding, right? Check the code.

Cheers,
Con
