Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTJBDim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 23:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbTJBDim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 23:38:42 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:43395
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263230AbTJBDil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 23:38:41 -0400
Message-ID: <3F7B9DA4.4040307@redhat.com>
Date: Wed, 01 Oct 2003 20:38:12 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20030913 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then using /proc/self/%d for some thread-local

I menat of course /proc/self/fd/%d

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------


