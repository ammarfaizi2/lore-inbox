Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWGXJOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWGXJOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 05:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWGXJOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 05:14:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:46925 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751092AbWGXJO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 05:14:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=bB/ZV6U0nqE1fPrsniMBIOGxzgqTTpg05hNaGTrn84tQ3dCQm4ZOyMaDD+I6G4UIjYraX0OpIwOY9kEAXFZjwFHpFCKiYJjimPaTbeKpFUH/w4NmpFoeKFSiN8FcUpSrEvRwLoenumbz7ZkRAET8MiXBF62FQyVIYpmSRN+kEvI=
Date: Mon, 24 Jul 2006 11:13:40 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Can't clone Linus tree
Message-ID: <20060724091340.GA596@leiferikson.gentoo>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060724080752.GA8716@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724080752.GA8716@irc.pl>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 24, 2006 at 10:07:52AM +0200, Tomasz Torcz wrote:
>  Errors occur constantly since yesterday. They of course appear after
> downloading several megabytes of data, which is unpleasant on my 128kbps
> connection.

I am on ISDN here and i'm using rsync transfer since having problems
with other protocols too. Just replace the git:// with rsync:// in your
URI and try again.

Hannes
