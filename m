Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbREMNyE>; Sun, 13 May 2001 09:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbREMNxy>; Sun, 13 May 2001 09:53:54 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:33287 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261402AbREMNxf>;
	Sun, 13 May 2001 09:53:35 -0400
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-acenic@SunSITE.auc.dk, linux-kernel@vger.kernel.org
Subject: Re: [patch] Acenic tigon 1 support fix
In-Reply-To: <20010430170138.A1085@nemesis.ncsl.nist.gov> <d3eltxt4hf.fsf@lxplus015.cern.ch> <20010510161104.A1949@zalem.puupuu.org>
From: Jes Sorensen <jes@sunsite.dk>
Date: 13 May 2001 15:53:00 +0200
In-Reply-To: Olivier Galibert's message of "Thu, 10 May 2001 16:11:04 -0400"
Message-ID: <d3bsoxtkxv.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Olivier" == Olivier Galibert <galibert@pobox.com> writes:

Olivier> On Thu, May 10, 2001 at 08:59:24PM +0200, Jes Sorensen wrote:
>> Thanks, I'll put that in the next driver release as well.

Olivier> Good.  The only bad thing is that even with this fix, the
Olivier> card doesn't work (recieves, but never transmits).  I'll have
Olivier> to look into it later, when I find time.

I wouldn't be surprised if the Tigon I support died with the zero copy
changes. I haven't tested Tigon I cards for a long time (at least not
this year) but if I find some time (wont be soon ;-) I might take a
look.

Cheers
Jes
