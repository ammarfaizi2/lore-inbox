Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbRENRVr>; Mon, 14 May 2001 13:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262345AbRENRVh>; Mon, 14 May 2001 13:21:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18188 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262334AbRENRV0>;
	Mon, 14 May 2001 13:21:26 -0400
Date: Mon, 14 May 2001 18:20:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, "H . J . Lu" <hjl@lucon.org>,
        "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
Message-ID: <20010514182051.A27311@flint.arm.linux.org.uk>
In-Reply-To: <m1k83kj7dj.fsf@frodo.biederman.org> <m1y9s1jbml.fsf@frodo.biederman.org> <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> <16874.989832587@redhat.com> <m1k83kj7dj.fsf@frodo.biederman.org> <8717.989859079@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8717.989859079@redhat.com>; from dwmw2@infradead.org on Mon, May 14, 2001 at 05:51:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 05:51:19PM +0100, David Woodhouse wrote:
> Well, if it stops working and stays broken, I suppose I'll just have to 
> hack up a built-in command line option. ISTR ARM already has such an option.

Indeed it does, because some platforms don't have any way to pass anything
to the kernel period.  (Because they are using a serial loader called
Angel).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

