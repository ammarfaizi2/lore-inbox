Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288804AbSBDJgk>; Mon, 4 Feb 2002 04:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSBDJga>; Mon, 4 Feb 2002 04:36:30 -0500
Received: from Backfire.WH8.TU-Dresden.De ([141.30.225.118]:2433 "EHLO
	backfire.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S288804AbSBDJgR>; Mon, 4 Feb 2002 04:36:17 -0500
Message-Id: <200202040933.g149Xidx006940@backfire.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=US-ASCII
From: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Organization: Networkadministrator WH8/DD/Germany
To: Jens Axboe <axboe@suse.de>, Erik Andersen <andersen@codepoet.org>,
        "Calin A. Culianu" <calin@ajvar.org>, linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
Date: Mon, 4 Feb 2002 10:33:44 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu> <20020204070414.GA19268@codepoet.org> <20020204085712.O29553@suse.de>
In-Reply-To: <20020204085712.O29553@suse.de>
X-PGP-fingerprint: 5A65 E2CC EB06 F110 4F45  AB34 DE58 C135 1361 35BD
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. Februar 2002 08:57 schrieb Jens Axboe:
> Yep, _no_ drives to date support queued event notification. However, a
> polled approach is really not too bad -- it simply means that we'll push
> it to user space instead. I've written a small utility for reference.

You're wrong.

PLEXTOR CD-R PX-W2410A
media removal
eject request
media removal
media removal

HITACHI DVD-ROM GD-2500
no media change
new media
media removal

Just my 2 cents.

-Gregor
