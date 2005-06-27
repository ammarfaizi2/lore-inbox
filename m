Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVF0P1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVF0P1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVF0PY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:24:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35026 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261758AbVF0PDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 11:03:18 -0400
Date: Mon, 27 Jun 2005 11:02:08 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: fix silly config option.
Message-ID: <20050627150207.GA15493@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20050627053928.GA9759@redhat.com> <20050627112120.GO3629@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627112120.GO3629@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 01:21:20PM +0200, Adrian Bunk wrote:
 > On Mon, Jun 27, 2005 at 01:39:28AM -0400, Dave Jones wrote:
 > 
 > > CONFIG_CONFIG_TUNER_MULTI_I2C probably isn't what the
 > > author meant to create.
 > >...
 > 
 > I can't find this option.
 > 
 > Which kernel is this patch against?
 
2.6.12-git8 (git9 also needs it)

		Dave
