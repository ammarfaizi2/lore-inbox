Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265251AbUEZF0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUEZF0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 01:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUEZF0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 01:26:23 -0400
Received: from hostmaster.org ([212.186.110.32]:30851 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S265251AbUEZF0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 01:26:22 -0400
Subject: Re: 2.6.6 and hard drive power-off on reboot?
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <40B419B6.2040507@ThinRope.net>
References: <40B419B6.2040507@ThinRope.net>
Content-Type: text/plain
Message-Id: <1085549179.14023.49.camel@forum-beta.geizhals.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 26 May 2004 07:26:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a well known bug:
http://bugzilla.kernel.org/show_bug.cgi?id=2732
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=122966

Tom

