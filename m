Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTE1WvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTE1WvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:51:12 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:61586 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261428AbTE1Wu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:50:56 -0400
Date: Thu, 29 May 2003 00:05:59 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel@vger.kernel.org
Subject: Re: OOPs report
Message-ID: <20030528230559.GA7810@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel@vger.kernel.org
References: <20030528151620.GA21579@the-penguin.otak.com> <20030528155342.45d1e437.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528155342.45d1e437.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 03:53:42PM -0700, Andrew Morton wrote:

 > yes, sorry.  -mm has extra list_head debugging goodies, and they detect
 > bugs in devfs.

I was wondering about that stuff actually..  Has it tripped up
anything other than devfs ?  It does look quite useful.

		Dave
