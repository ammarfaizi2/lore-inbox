Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265366AbUFBGiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUFBGiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 02:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUFBGiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 02:38:06 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:44701 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265366AbUFBGiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 02:38:03 -0400
Date: Wed, 2 Jun 2004 08:38:03 +0200
From: bert hubert <ahu@ds9a.nl>
To: Ben Greear <greearb@candelatech.com>
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: Select/Poll
Message-ID: <20040602063803.GA24706@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Ben Greear <greearb@candelatech.com>, davids@webmaster.com,
	linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKAEJIMFAA.davids@webmaster.com> <40BD6FDE.6090006@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BD6FDE.6090006@candelatech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can check that they get to the wire in (almost?) all cases by watching

QoS settings may drop your packet before actually hitting the wire, but
after being enqueued to the kernel.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
