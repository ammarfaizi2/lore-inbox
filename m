Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280186AbRJaM01>; Wed, 31 Oct 2001 07:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280185AbRJaM0Q>; Wed, 31 Oct 2001 07:26:16 -0500
Received: from [213.98.126.44] ([213.98.126.44]:11780 "HELO anano.mitica")
	by vger.kernel.org with SMTP id <S280182AbRJaM0F>;
	Wed, 31 Oct 2001 07:26:05 -0500
To: Shawn Walker <swalker@fs1.theiqgroup.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: status of supermount?
In-Reply-To: <200110241859.f9OIx7h27817@fs1.theiqgroup.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200110241859.f9OIx7h27817@fs1.theiqgroup.com>
Date: 31 Oct 2001 13:07:45 +0100
Message-ID: <m2ofmoui5q.fsf@anano.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "shawn" == Shawn Walker <swalker@fs1.theiqgroup.com> writes:

shawn> Does anyone know if supermount has been ported to a more recent kernel by anyone? The last version of supermount I could find was for 2.4.0

You can get patches from:

ftp://ftp.mandrakesoft.com/pub/quintela/

for 2.4.8-ac12, I have patches for more recent kernel, but they are
still not there.  I expect to put there tomorrow of the following day.

Any comments, suggestions are welcome.  I am in the middle of trying
ot get _some_ sane lock to supermount, as the beast basically don't
have any look at the moment, normally works due to de the fact that
normally there are not one hundred concurrent users of the floppy or
cd :(

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
