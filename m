Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270014AbTHESuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270092AbTHESuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:50:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61216 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S270014AbTHESuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:50:06 -0400
Date: Tue, 5 Aug 2003 19:51:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] revert to static = {0}
In-Reply-To: <20030805174429.GA26933@gtf.org>
Message-ID: <Pine.LNX.4.44.0308051949130.1849-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Jeff Garzik wrote:
> 
> If it's const, it shouldn't be linked into anything at all... right?

Sorry, Jeff, I don't get your point.

Hugh

