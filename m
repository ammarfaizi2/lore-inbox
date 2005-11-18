Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVKRTex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVKRTex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVKRTex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:34:53 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:34961 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750917AbVKRTew convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:34:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZQ5u13y+4tyiURKha79YTP+GOTGT7cPKMU3Bi6mTlxwj7Re9x763urmFZT3iNl5iHSg9DFMeMgAZNDJ7G5lKPsaGu3VbV6z6raH0iYg0HMEXL/NrNk5OA/EWYnu7D2L72xcjlyULklxuBJYugRqR9D3RKkUO1RQa2Fmqs906rGY=
Message-ID: <625fc13d0511181134lc074b8avcc8db47b8723583@mail.gmail.com>
Date: Fri, 18 Nov 2005 13:34:51 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [patch 1/3] Add SCM info to MAINTAINERS
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, scjody@steamballoon.com
In-Reply-To: <20051118173106.GB20860@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051118173930.270902000@press.kroah.org>
	 <20051118173054.GA20860@kroah.com> <20051118173106.GB20860@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/05, Greg Kroah-Hartman <gregkh@suse.de> wrote:
> From: Jody McIntyre <scjody@steamballoon.com>
>
> Add tree information to MAINTAINERS file.

Missed MTD git tree at:

git kernel.org:/pub/scm/linux/kernel/git/tglx/mtd-2.6.git

MTD also has a CVS tree... which begs the question as to whether or
not CVS trees can be added to the SCM type?

josh
