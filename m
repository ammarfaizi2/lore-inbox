Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUI0QjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUI0QjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUI0Qh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:37:56 -0400
Received: from peabody.ximian.com ([130.57.169.10]:20901 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266753AbUI0Qgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:36:52 -0400
Subject: Re: [gamin] [RFC][PATCH] inotify 0.10.0 [u]
From: Robert Love <rml@ximian.com>
To: azarah@gentoo.org
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, iggy@gentoo.org
In-Reply-To: <1096302649.11535.69.camel@nosferatu.lan>
References: <1096250524.18505.2.camel@vertex>
	 <1096302060.11535.54.camel@nosferatu.lan>
	 <1096302248.30503.21.camel@betsy.boston.ximian.com>
	 <1096302649.11535.69.camel@nosferatu.lan>
Content-Type: text/plain
Date: Mon, 27 Sep 2004 12:35:32 -0400
Message-Id: <1096302932.30503.27.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 18:30 +0200, Martin Schlemmer [c] wrote:

> Right, but using gamin, dnotify+poll support some things that inotify
> do not support.  Basically the dnotify backend also use the poll backend
> to enhance it to be able to monitor some events that dnotify by itself
> cannot (Daniel will be the better person to ask here).  Here is a small
> snippit from another thread:

I am thinking that we have two different definitions of poll here,
sorry.

I guess you mean poll as in some sort of Gamin backend type?

Anyhow, I guess this is a Gamin question, not a inotify kernel-side
question.

	Robert Love


