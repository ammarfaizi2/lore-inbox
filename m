Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVCNTkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVCNTkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVCNTkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:40:45 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:65385 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261769AbVCNTic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:38:32 -0500
Date: Mon, 14 Mar 2005 20:38:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, kaos@ocs.com.au, akpm <akpm@osdl.org>
Subject: Re: [PATCH] buildcheck: reduce DEBUG_INFO noise from reference* scripts
Message-ID: <20050314193841.GA17373@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, kaos@ocs.com.au,
	akpm <akpm@osdl.org>
References: <20050314110209.5ced9d9d.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314110209.5ced9d9d.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 11:02:09AM -0800, Randy.Dunlap wrote:
> 
> Reduce noise in 'make buildcheck' that is caused by CONFIG_DEBUG_INFO=y.

Applied to my kbuild tree.

	Sam
