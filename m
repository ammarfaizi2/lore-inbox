Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265992AbTFWLA4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbTFWLA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:00:56 -0400
Received: from [195.95.38.160] ([195.95.38.160]:65527 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S265992AbTFWLAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:00:55 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: MOD_DEC_USE_COUNT is deprecated
Date: Mon, 23 Jun 2003 13:16:21 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306231316.21018.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey List,

Little question: With many modules I'm still seeying the MOD_DEC_USE_COUNT is 
deprecated message. I've checked the changes that have been done earlier, and 
they usually just consist of removing these lines. If so, I'm more than 
willing to "search and destroy" those and send 'em over to the patch monkey, 
but if what I'm saying is totally idiotic just slap me ;p

Jan
-- 
Penguin laptop (i686) running GNU/Linux 2.5.72 #1 Tue Jun 17 17:43:31 CEST 
2003
The joys of love made her human and the agonies of love destroyed her.
		-- Spock, "Requiem for Methuselah", stardate 5842.8

