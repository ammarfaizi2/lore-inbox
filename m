Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263807AbUD0QF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUD0QF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUD0QF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:05:29 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:15821 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263807AbUD0QFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:05:25 -0400
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: c-d.hailfinger.kernel.2004@gmx.net, gilles@canalmusic.com,
       zwane@linuxpower.ca, torvalds@osdl.org, rusty@rustcorp.com.au,
       jbglaw@lug-owl.de, willy@w.ods.org
Content-Type: text/plain
Organization: 
Message-Id: <1083073392.3444.911.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Apr 2004 09:43:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see a need to get all complicated about this.
This is simple, really: since a C string ends at the
'\0', the module has been declared to be GPL code.
We shouldn't care if that C string is part of a larger
array. This is a damn obvious case of willful circumvention
of copyright control, access control, digital rights
management, etc.

Unleash the sharks.


