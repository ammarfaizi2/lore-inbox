Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUJDTKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUJDTKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUJDTH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:07:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267633AbUJDTHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:07:44 -0400
Date: Mon, 4 Oct 2004 14:32:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-mm@kvack.org, akpm@osdl.org, Nick Piggin <piggin@cyberone.com.au>,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-ID: <20041004173258.GN16374@logos.cnet>
References: <20041001182221.GA3191@logos.cnet> <4160B7A8.7010607@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4160B7A8.7010607@jp.fujitsu.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yeap that is a nice optimization, thanks Hiroyuki.

On Mon, Oct 04, 2004 at 11:38:32AM +0900, Hiroyuki KAMEZAWA wrote:
> 
> how about inserting this if-sentense ?
