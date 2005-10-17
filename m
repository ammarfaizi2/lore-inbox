Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVJQWky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVJQWky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVJQWkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:40:53 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:30659 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932355AbVJQWkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:40:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [PATCH 0/4] swsusp: more cleanups
Date: Mon, 17 Oct 2005 23:36:52 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172336.53194.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series of patches consists of some nonessential cleanups
for swsusp.  Still, if there are no objections, please consider them for
including in 2.6.15.

The patches are against 2.6.14-rc4-mm1 with the

swsusp-cleanups.patch
swsusp-remove-unneccessary-includes.patch

applied.

Greetings,
Rafael

