Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTHBOjt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 10:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTHBOjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 10:39:49 -0400
Received: from www.13thfloor.at ([212.16.59.250]:16853 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S263997AbTHBOjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 10:39:49 -0400
Date: Sat, 2 Aug 2003 16:39:57 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: nodev, noexec, nosuid, ro for --bind mounts?
Message-ID: <20030802143957.GA30396@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone!

is there any interest in having working 
nodev, noexec, nosuid, and ro mount options 
for --bind mounts?

I do not need this feature, but I guess I
know how to implement it, with a probably
tiny loss in performance ...

just let me know,
Herbert

