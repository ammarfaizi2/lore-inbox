Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWGYOkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWGYOkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWGYOkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:40:39 -0400
Received: from mailrelay3.sunrise.ch ([194.158.229.31]:15070 "EHLO
	obelix.sunrise.ch") by vger.kernel.org with ESMTP id S932316AbWGYOkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:40:39 -0400
Date: Tue, 25 Jul 2006 10:40:27 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Arthur Othieno <apgo@patchbomb.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: make CONFIG_EFI depend on EXPERIMENTAL
Message-ID: <20060725144027.GA23078@krypton>
References: <20060720001321.GC8584@krypton> <20060725005310.4877390d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725005310.4877390d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 12:53:10AM -0700, Andrew Morton wrote:
> Some poor soul will surely wonder where his EFI support went to and why his
> box won't boot.
> 
> So I went the other way and removed the " (EXPERIMENTAL)"

Ok, that looks more sane. Thanks.
