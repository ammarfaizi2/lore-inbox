Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265785AbUF2Ppx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUF2Ppx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 11:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265787AbUF2Ppx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 11:45:53 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:1937 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265785AbUF2Ppx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 11:45:53 -0400
Date: Tue, 29 Jun 2004 17:45:51 +0200
From: bert hubert <ahu@ds9a.nl>
To: Debi Janos <debi.janos@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-ID: <20040629154551.GA6181@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Debi Janos <debi.janos@freemail.hu>, linux-kernel@vger.kernel.org
References: <freemail.20040529152006.85505@fm4.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <freemail.20040529152006.85505@fm4.freemail.hu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 03:20:06PM +0200, Debi Janos wrote:
> I am found an interesting (bug?) feature in kernels between
> 2.6.7-mm1 and 2.6.7-mm4

Without further looking at it, try checking if ECN is turned on.
/proc/sys/net/ipv4/tcp_ecn if memory serves me well.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
