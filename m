Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWA1QdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWA1QdE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWA1QdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:33:04 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:457 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1751469AbWA1QdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:33:02 -0500
Date: Sat, 28 Jan 2006 18:33:01 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: geocities.com URLs are now banned..
Message-ID: <20060128163301.GK3927@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... which is sad, because we have some people who do have
legitimate and relevant-to-linux contents in those URLs, but
this spam trouble using geociries URLs is getting rather
excessive.

Our rejection pattern matches:  ". geocities . com /"
(case insensitive, and minus spaces) so if you need
to point an URL there, do so with extra spaces.

No idea if spammers will adapt by adding spaces, and entice
people to fix URLs...   If that day happens, then perhaps
the only way to get email back into usabe form is to classify
spamming and spamming support (in USA and China, very least)
to be equally bad thing, as terrorism and have equally severe
punishment...

/Matti Aarnio -- sad because of used harsh methods..
