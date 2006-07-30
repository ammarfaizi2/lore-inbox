Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWG3MXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWG3MXF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWG3MXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:23:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:47271 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932298AbWG3MXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:23:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=shg1v9PCTuNVfma5939kHbYHelDpMXKWs1lQbUD0PIgVH//Rfvj4rMv9MRJClFiSnh747/DqHZFxMne/IAEe0eM8HiujUNYKARF2/qFL6Cm032BdzY9B7S+SWJQ6dPKUhEjEaHXNU/D+7TmgnYqjof9wxYGYsy1wLApEj9pNnXk=
Date: Sun, 30 Jul 2006 14:22:03 +0200
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
Message-ID: <20060730122203.GA13169@leiferikson.dystopia.lan>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44CC9F7E.8040807@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CC9F7E.8040807@t-online.de>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 30, 2006 at 02:01:02PM +0200, Harald Dunkel wrote:
> Hi folks,
> 
> I tried to spin down my harddisk using hdparm, but when it is
> supposed to spin up again, [...]

When is the point reached to spin up again?

> On another machine (with a SAMSUNG SP2504C inside) there is no
> such problem: The disk is back after just a few seconds.

Same kernel?

Hannes
