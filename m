Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131054AbRARM5v>; Thu, 18 Jan 2001 07:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130615AbRARM5c>; Thu, 18 Jan 2001 07:57:32 -0500
Received: from felix.convergence.de ([212.84.236.131]:4877 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S130138AbRARM5V>;
	Thu, 18 Jan 2001 07:57:21 -0500
Date: Thu, 18 Jan 2001 13:56:35 +0100
From: Felix von Leitner <leitner@convergence.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Documenting stat(2)
Message-ID: <20010118135635.A12276@convergence.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	"Eric S. Raymond" <esr@thyrsus.com>
In-Reply-To: <20010118002812.A19810@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010118002812.A19810@thyrsus.com>; from esr@thyrsus.com on Thu, Jan 18, 2001 at 12:28:12AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Eric S. Raymond (esr@thyrsus.com):
> Here is what I think I know about stat(2) that isn't in the
> Linux man pages:

> * For a symlink (S_IFLNK) it reports the size of the link file, not the
> size of the file the link points to.

I think you confuse stat and lstat here.

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
