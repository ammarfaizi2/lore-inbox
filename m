Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUENNsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUENNsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUENNsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:48:43 -0400
Received: from legolas.drinsama.de ([62.91.17.164]:39342 "EHLO
	legolas.drinsama.de") by vger.kernel.org with ESMTP id S265281AbUENNsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:48:36 -0400
Subject: Re: Bug in bridge interface removal?
From: Erich Schubert <erich@debian.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1084542378.17594.12.camel@wintermute.xmldesign.de>
References: <1084542378.17594.12.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Organization: Debian GNU/Linux Developers
Message-Id: <1084542509.17594.15.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Fri, 14 May 2004 15:48:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, this is fixed in 2.6, and the fix is neater than mine.
I only looked at "del_nbp".

Backporting that from 2.6.x is probably nicer than my fix.

Greetings,
Erich

