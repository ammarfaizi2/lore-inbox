Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135808AbRAGIQR>; Sun, 7 Jan 2001 03:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135908AbRAGIQH>; Sun, 7 Jan 2001 03:16:07 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:36087 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135808AbRAGIPz>;
	Sun, 7 Jan 2001 03:15:55 -0500
To: Matthias Juchem <juchem@uni-mannheim.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new bug report script
In-Reply-To: <Pine.LNX.4.30.0101070858400.7104-100000@gandalf.math.uni-mannheim.de>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 07 Jan 2001 00:16:10 -0800
In-Reply-To: Matthias Juchem's message of "Sun, 7 Jan 2001 09:01:48 +0100 (CET)"
Message-ID: <m3elyfbwvp.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Juchem <matthias@gandalf.math.uni-mannheim.de> writes:

> Or is the file name scheme reliable (/lib/libc.so.5.x.y)?

Yes, since this was how HJ named the releases.  You have to find out
which version is actually used (there might be several .so files
there).

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
