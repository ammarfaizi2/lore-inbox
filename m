Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWB1QYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWB1QYi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWB1QYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:24:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33713 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751813AbWB1QYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:24:38 -0500
Date: Tue, 28 Feb 2006 11:24:35 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory compression (again). . help?
In-Reply-To: <4403C30A.6070704@comcast.net>
Message-ID: <Pine.LNX.4.63.0602281123410.15105@cuia.boston.redhat.com>
References: <4403A14D.4050303@comcast.net> <4403C30A.6070704@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006, John Richard Moser wrote:

> Hmm, I can't see where the kernel checks to see which pages are least
> used. . . . anyone good with the VM can point me in the right direction?

Not completely written yet, but take a look at:

	http://linux-mm.org/PageOutKswapd


-- 
All Rights Reversed
