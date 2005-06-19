Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVFSNQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVFSNQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 09:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFSNQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 09:16:49 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:12339 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261682AbVFSNQp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 09:16:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LrBHIRF9YixOBf4XELrJaH90mRvUTq59qyXnYVYEWCKXARddgd5QU+FMW+5c2LQAwTkORwWL5R2KOGVK4yEP4VYS+NF6TPhFrgKanCRdsfbFdbeTHQOy5P11QIPUNOIVoOm65NcwdDByvL0JkdOziKml2+e7DuREhwkWZGmRM98=
Message-ID: <4ad99e0505061906163d3cbe3e@mail.gmail.com>
Date: Sun, 19 Jun 2005 15:16:42 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Cc: Lincoln Dale <ltd@cisco.com>, Valdis.Kletnieks@vt.edu,
       Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42B4ACB1.7030807@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <001f01c57341$1802c3b0$600cc60a@amer.sykes.com>
	 <200506171352.j5HDqpE8006543@turing-police.cc.vt.edu>
	 <42B353B7.4070503@cisco.com>
	 <4ad99e05050617222966671e4f@mail.gmail.com>
	 <42B4ACB1.7030807@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> If you have a Cisco contract, you need to make sure that your account
> manager will allow the upgrades.
> 
> But as I said before, this was fixed long time ago.

It was not fixed completly in PIX 6.1.5, at this point I now have 3
pixes that all have this problem and all of them are running 6.3.4 I
have asked them to upgrade to 6.3.4.115 and will report back as soon I
have any results.
