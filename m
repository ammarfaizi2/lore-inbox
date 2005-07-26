Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVGZTgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVGZTgz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVGZTgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:36:54 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:55665 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261886AbVGZTgu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:36:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ZOJRCJxVnNtESI2lcs+EbFxovbOM26DJk/BS6ZZ5v7EzyG5lwqSuT0U3eXeUD8KWYy3M5J5jB57sHPaOBeHbUTpRgeV/DwCmE7zCUz7oeD5vD8fdIe4iJyY14Wn0glsMTI3mO0PBEusknIcxctrzWwYCfXp8kedBZyjffD+JF/U=
Date: Tue, 26 Jul 2005 21:36:43 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux BKCVS kernel history git import..
Message-Id: <20050726213643.7ca44e96.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 26 Jul 2005 11:57:43 -0700 (PDT),
Linus Torvalds <torvalds@osdl.org> escribió:

> I'm planning on doing the 2.4 tree too some day - either as a separate
> branch in the same archive, or as a separate git archive, I haven't quite

It'd be great  to have the same thing but for the 1.0 - 2.2 tree. Of course
there are no "changelogs" for that, but incremental patches are still
available, and it'd be very interesting (for "historical reasons") to see how
things were added/removed
