Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRDPRmM>; Mon, 16 Apr 2001 13:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131756AbRDPRmD>; Mon, 16 Apr 2001 13:42:03 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:11071 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S131733AbRDPRlp>;
	Mon, 16 Apr 2001 13:41:45 -0400
Message-ID: <20010416194147.A16559@win.tue.nl>
Date: Mon, 16 Apr 2001 19:41:47 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: ebiederm@xmission.com (Eric W. Biederman),
        "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
In-Reply-To: <20010413150219.A440@napalm.go.cz> <20010414002120.A15596@win.tue.nl> <9b83i5$ha7$1@cesium.transmeta.com> <m1itk5tl1k.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <m1itk5tl1k.fsf@frodo.biederman.org>; from Eric W. Biederman on Mon, Apr 16, 2001 at 12:29:11AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 12:29:11AM -0600, Eric W. Biederman wrote:

> If we can try to keycodes in 8-bits it would be nice.  The difficulty
> is that X cannot handle more than 8-bits without telling it you have
> multiple keyboards.  The keycode (at least in X) is exported to
> X applications.  This is certainly something to coordinate with the
> XFree folks about.  If you really need more then 8-bits. 

X keycodes are unrelated to Linux keycodes.
