Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVDFMWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVDFMWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVDFMWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:22:12 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:64598 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262186AbVDFMWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:22:02 -0400
Date: Wed, 6 Apr 2005 13:22:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: =?ISO-8859-1?Q?Kenneth_Aafl=F8y?= <lists@kenneth.aafloy.net>,
       Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style: mixed-case
In-Reply-To: <4253A584.2000201@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0504061318470.22173@goblin.wat.veritas.com>
References: <200504060329.21469.lists@kenneth.aafloy.net> 
    <20050406020929.GJ25554@waste.org> 
    <200504060437.40256.lists@kenneth.aafloy.net> 
    <4253A584.2000201@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2005, Nick Piggin wrote:
> Don't use PF_*. That namespace is already being used by at least
> process flags and protocol flags. Maybe page_locked, page_dirty,
> etc. might be better

Much better.  But...

> Lastly, it is quite likely that many people will consider this to be
> more trouble than it's worth. So keep in mind it is not guaranteed to
> get included.

Count me among them - IMHO it's a worthless change.

Hugh
