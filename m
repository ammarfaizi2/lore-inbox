Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752638AbWAHRPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbWAHRPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbWAHRPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:15:50 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:42898 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1752638AbWAHRPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:15:49 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 0/2] swsusp: low level interface (rev. 2)
Date: Sun, 8 Jan 2006 18:07:22 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601081807.22740.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second revision of the patches that prepare swsusp for the
introduction of the userland interface.

Please consider for applying (Pavel, if you agree with the current version,
please ack or sign off).

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

