Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVJ3PwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVJ3PwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVJ3PwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:52:16 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:27825 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932090AbVJ3PwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:52:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] swsusp: code separation continued
Date: Sun, 30 Oct 2005 16:37:48 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301637.48842.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series of patches continues the process of separating the
snapshot-handling code in swsusp from the storage-handling and core
code.

The patches are against the vanilla 2.6.14-rc5-mm1.  They have already been
acked by Pavel.  Please apply.

Greetings,
Rafael

