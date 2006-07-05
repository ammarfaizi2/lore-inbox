Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWGEIvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWGEIvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWGEIvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:51:13 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:3484 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932407AbWGEIvM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:51:12 -0400
Subject: Re: [RESEND][PATCH] Script for automated historical Git tree
	grafting
From: Marcel Holtmann <marcel@holtmann.org>
To: Petr Baudis <pasky@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060608013330.GA24203@pasky.or.cz>
References: <20060608013330.GA24203@pasky.or.cz>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 10:50:58 +0200
Message-Id: <1152089458.4260.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

> This script enables Git users to easily graft the historical Git tree
> (Bitkeeper history import) to the current history.

it would be nice if you can specify a local location for the history
tree, because some people might already downloaded it.

And what about the tags of the history tree. It seems that these are
missing. We need to copy them, too.

Regards

Marcel


