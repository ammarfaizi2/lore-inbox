Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130831AbRC0Idf>; Tue, 27 Mar 2001 03:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRC0IdZ>; Tue, 27 Mar 2001 03:33:25 -0500
Received: from adsl-64-163-64-75.dsl.snfc21.pacbell.net ([64.163.64.75]:21265
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S130793AbRC0IdK>; Tue, 27 Mar 2001 03:33:10 -0500
Message-ID: <3AC05024.747A2AD6@konerding.com>
Date: Tue, 27 Mar 2001 00:32:36 -0800
From: David Konerding <dek_ml@konerding.com>
X-Mailer: Mozilla 4.73 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: "mount -o loop" lockup issue
In-Reply-To: <E14hkwq-0002y0-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > It's a bug in Linux 2.4.2, fixed in later versions.  Regression/quality control
> > testing would
> > have caught this, but the developers usually just break things and wait for people
> > to complain
> > as their "Regression" testers.
>
> Hardly. We knew it was broken since well before 2.4.0. It just got a little
> interesting to fix.

And this is described in what release notes?  It worked just fine on Red Hat 7.0's 2.4
kernel.... oh wait, I see that they fixed it before they released it.

