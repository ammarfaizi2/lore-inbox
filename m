Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbREOQFw>; Tue, 15 May 2001 12:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261921AbREOQFm>; Tue, 15 May 2001 12:05:42 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:29188 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S261405AbREOQFd>;
	Tue, 15 May 2001 12:05:33 -0400
Date: Tue, 15 May 2001 09:05:31 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
Message-ID: <20010515090531.B12586@lucon.org>
In-Reply-To: <m1k83kj7dj.fsf@frodo.biederman.org> <m1y9s1jbml.fsf@frodo.biederman.org> <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> <16874.989832587@redhat.com> <8717.989859079@redhat.com> <m1eltqkars.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1eltqkars.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Tue, May 15, 2001 at 07:21:59AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The clean way to handle it, and I'll take a look it to have
> root=/dev/nfs (and the rdev equivalent) to set ip=on if it isn't

Yes.

> already.  The current 2.4.4 behavior of root=/dev/hda3 doing ip
> autoconfig when the code is compiled into the kernel is just bad.

Agreed.


H.J.
