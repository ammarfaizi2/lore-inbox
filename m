Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSBZSyX>; Tue, 26 Feb 2002 13:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292680AbSBZSyM>; Tue, 26 Feb 2002 13:54:12 -0500
Received: from [208.147.64.186] ([208.147.64.186]:9383 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S292666AbSBZSyA>; Tue, 26 Feb 2002 13:54:00 -0500
Date: Tue, 26 Feb 2002 10:51:34 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Dana Lacoste <dana.lacoste@peregrine.com>
cc: "'Andreas Dilger'" <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>
Subject: RE: ext3 and undeletion
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2C09@ottonexc1.ottawa.loran.com>
Message-ID: <Pine.LNX.4.44.0202261051120.13806-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

only if you check them in between writes.

david Lang

On Tue, 26 Feb 2002, Dana Lacoste wrote:

> > Snapshots at the filesystem level could handle the overwrite case.
>
> We need BitKeeperFS!  It stores the diff'd history of all changes to all
> files!
>
> :)
>
> Dana Lacoste
> Ottawa, Canada
