Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVFSPAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVFSPAN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 11:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVFSPAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 11:00:13 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:6986 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262250AbVFSPAH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 11:00:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iaD/DM0VgMamR99SlCdhrrTIXb//em7NOy2XV4mZkf9P2/FRSR3DfgWSGDyR3ffY0dgfkOBd4tOmmo4Kp+plz77+dhoZT+w9hpwTvswSXN1p8jhd969rqRhA3xQYLOujTZb5u5fWZ9bXtWqdybvDoBdrDFH1VKlcGaZi+raMWxg=
Message-ID: <9cde8bff0506190800170a3685@mail.gmail.com>
Date: Sun, 19 Jun 2005 10:00:05 -0500
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: Linux 2.6.12
Cc: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050618193636.70ab8b05.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506182005.28254.nick@linicks.net>
	 <9a8748490506181233675f2fd5@mail.gmail.com>
	 <9cde8bff0506181839d41aab3@mail.gmail.com>
	 <Pine.LNX.4.62.0506181847550.11617@qynat.qvtvafvgr.pbz>
	 <20050618193636.70ab8b05.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/05, randy_dunlap <rdunlap@xenotime.net> wrote:
> On Sat, 18 Jun 2005 18:48:59 -0700 (PDT) David Lang wrote:
> 
> | On Sat, 18 Jun 2005, aq wrote:
> |
> | > the version number is a little bit confused here: if I want to upgrade
> | > from for example 2.6.11.5 to 2.6.12, which patch should I get?
> |
> | you reverse the 2.6.11 -> 2.6.11.5 patch to get back to a vinilla 2.6.11
> | then you apply the 2.6.11->2.6.12 patch.
> 
> Hrm, I expected ketchup to be able to handle that already.
> Does it not?

ah yes. because 2.6.12 can be get by patching from 2.6.11, so ketchup
works well, as always.

but ketchup doesnt work with 2.6.x.y yet.

regards,
aq
