Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754648AbWKMNwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbWKMNwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 08:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654AbWKMNwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 08:52:17 -0500
Received: from cadalboia.ferrara.linux.it ([195.110.122.101]:24800 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S1754648AbWKMNwR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 08:52:17 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Remi <remi.colinet@free.fr>
Subject: Re: 2.6.19-rc5-mm1 : probe of 0000:00:1f.2 failed with error -16
Date: Mon, 13 Nov 2006 14:52:11 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <1163425477.455876c5637f6@imp4-g19.free.fr>
In-Reply-To: <1163425477.455876c5637f6@imp4-g19.free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611131452.13234.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 14:44, lunedì 13 novembre 2006, Remi ha scritto:
> Hello,
>
> Since after 2.6.18-mm3, I'm unable to boot mm trees getting the following
> message:
>
> ata_piix: probe of 0000:00:1f.2 failed with error -16
> Kernel panic - not syncing: Attempted to kill init!
>
> I disabled most options in my .config file just keeping ata_piix enabled.
> 2.6.19-rc5 still boots fine but 2.6.19-rc-mm1 gives the same previous
> message.


It seems exactly the same problem that is hitting me:

http://lkml.org/lkml/2006/11/13/37

If some patch comes out, I'll be willing to try it asap ;)



-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
