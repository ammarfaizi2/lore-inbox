Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSGGQvr>; Sun, 7 Jul 2002 12:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSGGQvq>; Sun, 7 Jul 2002 12:51:46 -0400
Received: from ns.suse.de ([213.95.15.193]:35333 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316135AbSGGQvq>;
	Sun, 7 Jul 2002 12:51:46 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, jmorris@intercode.com.au
Subject: Re: [PATCH] simplify networking fcntl
References: <20020707171555.L27706@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Jul 2002 18:54:22 +0200
In-Reply-To: Matthew Wilcox's message of "7 Jul 2002 18:18:30 +0200"
Message-ID: <p73d6tzwkap.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I believe James Morris did this (clean up network fcntl) already in a more 
complex patchkit that also cleans up the SIGIO/SIGURG sending. 
Perhaps you coordinate with him.

-Andi
