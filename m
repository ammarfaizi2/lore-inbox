Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbTCEOZj>; Wed, 5 Mar 2003 09:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTCEOZj>; Wed, 5 Mar 2003 09:25:39 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:13323 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264956AbTCEOZi>; Wed, 5 Mar 2003 09:25:38 -0500
Date: Wed, 5 Mar 2003 14:36:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: davej@suse.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.64
Message-ID: <20030305143608.A24878@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, davej@suse.de,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Mar 04, 2003 at 07:48:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o [WATCHDOG] Remove old unneeded borken module locking

You just removed the nowayout functionality..

