Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312316AbSDPKp6>; Tue, 16 Apr 2002 06:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312255AbSDPKp5>; Tue, 16 Apr 2002 06:45:57 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:7942 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S312208AbSDPKp4>;
	Tue, 16 Apr 2002 06:45:56 -0400
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: implementing soft-updates
Date: 16 Apr 2002 12:45:53 +0200
Organization: Cistron Group
Message-ID: <a9gvd1$hsd$1@picard.cistron.nl>
In-Reply-To: <20020409184605.A13621@cecm.usp.br.suse.lists.linux.kernel> <20020410092807.GA4015@duron.intern.kubla.de.suse.lists.linux.kernel> <p73adsbpdaz.fsf@oldwotan.suse.de> <20020408203515.B540@toy.ucw.cz>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020408203515.B540@toy.ucw.cz>,
Pavel Machek  <pavel@suse.cz> wrote:
>How do you fix errors you find by such background fsck?

Theoretically I suppose you could use a writeable snapshot and then switch the
fscked snapshot with the currently mounted fs.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

