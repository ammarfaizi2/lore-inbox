Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVAJJK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVAJJK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 04:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVAJJK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 04:10:27 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:35830 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262162AbVAJJKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 04:10:24 -0500
Date: Mon, 10 Jan 2005 04:10:22 -0500
From: Hikaru1@verizon.net
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: PROBLEM: ide-cd in 2.6.8-2.6.10 and 2.4.26-2.4.28 high cpu use with dma
Message-ID: <20050110091022.GA20178@roll>
References: <20050109105201.GB12497@roll> <20050109105418.GD12497@roll> <20050109123028.GA12753@roll> <20050109153212.GA28417@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050109153212.GA28417@suse.de>
User-Agent: Mutt/1.4.2.1i
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [70.19.162.94] at Mon, 10 Jan 2005 03:10:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 04:32:16PM +0100, Jens Axboe wrote:
> The change isn't safe, it was made for a reason since some drives
> timeout if the alignment/length isn't correct. It probably is a little
> pessimistic right now, can you see if this just works for you?

Owner of the system tested the patch, works perfectly on his system.

Thanks :)

Timothy C. McGrath
