Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313716AbSDHUXd>; Mon, 8 Apr 2002 16:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313718AbSDHUXc>; Mon, 8 Apr 2002 16:23:32 -0400
Received: from ns.suse.de ([213.95.15.193]:24846 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313716AbSDHUXc>;
	Mon, 8 Apr 2002 16:23:32 -0400
To: Claus Fischer <claus.fischer@clausfischer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Spoof protection with redundant routes
In-Reply-To: <20020408220215.A1987@clausfischer.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Apr 2002 22:23:23 +0200
Message-ID: <p73d6xaos78.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claus Fischer <claus.fischer@clausfischer.com> writes:

> - Is that known and by design?

Yes.

> - Is that the desired behaviour?

Yes.

> - Is there some possibility to change that?

You could define a multipath route with multiple nexthops (needs iproute2)

-Andi
