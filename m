Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVAIMac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVAIMac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 07:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVAIMac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 07:30:32 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:41617 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261317AbVAIMaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 07:30:30 -0500
Date: Sun, 9 Jan 2005 07:30:28 -0500
From: Hikaru1@verizon.net
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-cd in 2.6.8-2.6.10 and 2.4.26-2.4.28 high cpu use with dma
Message-ID: <20050109123028.GA12753@roll>
References: <20050109105201.GB12497@roll> <20050109105418.GD12497@roll>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050109105418.GD12497@roll>
User-Agent: Mutt/1.4.2.1i
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [70.19.162.94] at Sun, 9 Jan 2005 06:30:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A minor mistake. I forgot to state explicitly that the problem only appears
with writing audio cds. Writing data cds does not cause problems.

Timothy C. McGrath
