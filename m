Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWFBRn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWFBRn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWFBRn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:43:58 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43392 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751346AbWFBRn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:43:57 -0400
Date: Fri, 2 Jun 2006 10:46:15 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH 2.6.16.19] sbp2: backport read_capacity workaround for iPod
Message-ID: <20060602174615.GR18769@moss.sous-sol.org>
References: <tkrat.b9bf60697156ef7b@s5r6.in-berlin.de> <20060530231917.GI18769@moss.sous-sol.org> <447DC82A.3000501@s5r6.in-berlin.de> <tkrat.26f002591ab59cf8@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.26f002591ab59cf8@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> sbp2: backport read_capacity workaround for iPod

Thank you for the smaller backport Stefan.  Patch queued.
-chris
