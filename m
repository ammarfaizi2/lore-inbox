Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280031AbRKVQju>; Thu, 22 Nov 2001 11:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280041AbRKVQjm>; Thu, 22 Nov 2001 11:39:42 -0500
Received: from ix.meyering.net ([212.234.50.122]:8081 "EHLO
	pixie.eng.ascend.com") by vger.kernel.org with ESMTP
	id <S280031AbRKVQjY>; Thu, 22 Nov 2001 11:39:24 -0500
To: troy@holstein.com
Cc: Padraig Brady <Padraig@AnteFacto.com>
Cc: kaos@ocs.com.au, markorr@intersurf.com, linux-kernel@vger.kernel.org,
        bug-fileutils@gnu.org
Subject: Re: [2.4.15pre6] Funny error on "make modules_install" - cosmetic cleanup probably needed
In-Reply-To: <5682.1006173890@ocs3.intra.ocs.com.au>
	<200111211400.fALE0Gm03949@pcx4168.holstein.com>
In-Reply-To: <200111211400.fALE0Gm03949@pcx4168.holstein.com> ("Todd M. Roy"'s message of "Wed, 21 Nov 2001 09:00:16 -0500")
From: Jim Meyering <jim@meyering.net>
Date: Thu, 22 Nov 2001 17:39:22 +0100
Message-ID: <87u1vmyd39.fsf@pixie.eng.ascend.com>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1.50 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report.
That will be fixed in fileutils-4.1.2.

"Todd M. Roy" <troy@holstein.com> wrote:
> I noticed this problem with the latest version of fileutils
> from alpha.gnu.org, (fileutils-4.1.1.tar.bz2) I reverted to 4.1
> and the problem disappeared.
...
[`cp a a d/' now fails]
