Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTKYUSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTKYUSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:18:49 -0500
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:4084
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S263015AbTKYUSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:18:45 -0500
Date: Tue, 25 Nov 2003 21:18:42 +0100
From: Antonio Vargas <wind@cocodriloo.com>
To: "Pravin Nanaware , Gurgaon" <pnanaware@ggn.hcltech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Copy protection of the floppies
Message-ID: <20031125201842.GC30083@wind.cocodriloo.com>
References: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 11:07:29AM +0530, Pravin Nanaware , Gurgaon wrote:
> Hi All,
> 
> 1> Could somebody suggest me the way to protect floppy from copying it's
> contents. 
> 2> If not possible, will it be possible to make the copied floppy unworkable
> (The copied floppy shouldn't work).  
>    For this I have constraint, I don't want to change the platform, which
> reads this floppy.
> 
> 
> The contents of the floppy could be anything like text file, exe file or
> encrypted file.
> 
> Regards,
> Pravin.

Usual PC floppy controllers are not very flexible, so you just need
some more-flexible controller to do the trick. A popular choice
for creating master disks is to get an Amiga with an 1.44 floppy
(any A4000 will do), make some scratched disks and then duplicate
them with some fine 1990-ish hardware disk copier.


-- 
winden/network

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
