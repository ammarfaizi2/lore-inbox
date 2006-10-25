Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWJYOvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWJYOvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWJYOvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:51:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39339 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932441AbWJYOvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:51:07 -0400
Date: Wed, 25 Oct 2006 07:50:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jes Sorensen <jes@sgi.com>
cc: Junio C Hamano <junkio@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: [git failure] failure pulling latest Linus tree
In-Reply-To: <yq0d58g92u0.fsf@jaguar.mkp.net>
Message-ID: <Pine.LNX.4.64.0610250746000.3962@g5.osdl.org>
References: <yq0d58g92u0.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Oct 2006, Jes Sorensen wrote:
> 
> Known error? git tree corrupted or need for a new version of git?

For some reason, the mirroring seems to be really slow or broken to one of 
the public servers (zeus-pub1). It looks to be affecting gitweb too (ie 
www1.kernel.org is busted, while www2.kernel.org seems ok)

		Linus
