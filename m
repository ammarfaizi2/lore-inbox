Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270868AbTGPNsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270866AbTGPNsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:48:39 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:37507 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S270868AbTGPNsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:48:36 -0400
Date: Wed, 16 Jul 2003 07:03:27 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.0-test1-mm1
Message-ID: <20030716140327.GC25829@ip68-4-255-84.oc.oc.cox.net>
References: <20030715225608.0d3bff77.akpm@osdl.org> <20030716104448.GC25869@ip68-4-255-84.oc.oc.cox.net> <20030716035848.560674ac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716035848.560674ac.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 03:58:48AM -0700, Andrew Morton wrote:
> Try this:
[patch snipped]

That eliminates the shift-related warnings quite nicely.

-Barry K. Nathan <barryn@pobox.com>
