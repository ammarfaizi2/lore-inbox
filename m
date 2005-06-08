Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVFHKRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVFHKRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVFHKRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:17:31 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:59062 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262151AbVFHKR1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:17:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f7sr6u6e8z6SqEYungELzsQ1J9EKaBUph4FsTRfZtpxqi7kvMewMmdStNPeZZCcq6kjOdCP5Is6RFtHmaNBLilvSDztYrzTQO4Slb+wSeGOLQSQ5H2ybTB1HB1vGQAcZZdL52uctzfSUrFc2pFKsehq49uZiI3Jfw1fqlYwsUcY=
Message-ID: <58cb370e050608031763ee7176@mail.gmail.com>
Date: Wed, 8 Jun 2005 12:17:27 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: li nux <lnxluv@yahoo.com>
Subject: Re: oops on using io_submit
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20050608075441.97875.qmail@web33315.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050608075441.97875.qmail@web33315.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, li nux <lnxluv@yahoo.com> wrote:
> I am getting kernel oops on using io_submit in my
> application, trying to read 500Mb files.
> sometimes the system freezes.
> any idea why this is happening ?
> I am using sles9.

* report bug to SuSE/Novell :)
* retry with the latest kernel.org kernel (2.6.12-rc6)
  and see if this bug still happens (please report this)

Bartlomiej
