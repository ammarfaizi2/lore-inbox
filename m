Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVJKSAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVJKSAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVJKSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:00:09 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:33704 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932241AbVJKSAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:00:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] swsusp improvements
Date: Tue, 11 Oct 2005 19:48:10 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200510111948.11242.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches improve swsusp and/or prepare it for further
cleanups and improvements.

The patches have been tested quite thoroughly and hopefully they
can be considered as 2.6.15 material.  Please apply.

All three patches have already been ACKed by Pavel.

Greetings,
Rafael

