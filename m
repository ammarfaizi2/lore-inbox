Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTCTNwr>; Thu, 20 Mar 2003 08:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbTCTNwr>; Thu, 20 Mar 2003 08:52:47 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:52276 "EHLO
	trasno.mitica") by vger.kernel.org with ESMTP id <S261456AbTCTNwq>;
	Thu, 20 Mar 2003 08:52:46 -0500
To: Tigran Aivazian <tigran@veritas.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, mirrors <mirrors@kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet> (Tigran
 Aivazian's message of "Wed, 19 Mar 2003 21:12:03 +0000 (GMT)")
References: <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet>
Date: Thu, 20 Mar 2003 15:03:45 +0100
Message-ID: <86d6kmrv7i.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "tigran" == Tigran Aivazian <tigran@veritas.com> writes:

tigran> On Wed, 19 Mar 2003, H. Peter Anvin wrote:
>> i) Does this sound reasonable to everyone?  In particular, is there any
>> loss in losing the "original" compressed files?

tigran> No, there is at least one reason for the "original" .gz files. Here are 
tigran> the logical steps:

tigran> a) any Linux distribution contains their own "linux" package with the 
tigran> source base being "vanilla" Linux .tar.gz file

Mandrake also use .bz2 since ages ago.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
