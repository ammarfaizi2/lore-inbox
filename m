Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317572AbSFRT2h>; Tue, 18 Jun 2002 15:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSFRT2g>; Tue, 18 Jun 2002 15:28:36 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:31872 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317572AbSFRT2f>; Tue, 18 Jun 2002 15:28:35 -0400
Date: Tue, 18 Jun 2002 21:34:15 +0200
Organization: Pleyades
To: austin@digitalroadkill.net, raul@pleyades.net
Subject: Re: Shrinking ext3 directories
Cc: linux-kernel@vger.kernel.org
Message-ID: <3D0F8B37.mailH8O114KDC@viadomus.com>
References: <3D0F5AFC.mailGSE111D9L@viadomus.com>
 <1024416626.7681.39.camel@UberGeek>
In-Reply-To: <1024416626.7681.39.camel@UberGeek>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Austin :)

>Use a volume manager?(LVM or EVMS maybe.) You can grow and shrink
>their volumes dynamically. EXT3 mus support ioctls for this, but if
>it does, cause I've seen it doesn with EXT2, then you're good.

    I'm afraid I explained myself bad O:) I didn't refer to directory
contents, but to the metadata, or the blocks of the directory itself.

    Thanks anyway :))
    Raúl
