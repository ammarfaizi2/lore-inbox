Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVLDXAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVLDXAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVLDXAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:00:42 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:49833 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932300AbVLDXAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:00:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/2][Fix][mm] swsusp: fix handling of highmem
Date: Sun, 4 Dec 2005 23:46:11 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512042346.11731.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following two patches are necessary to fix the way in which swsusp (in
the current -mm) handles highmem.

The patches have been acked by Pavel (Pavel, please confirm).

Please apply.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

