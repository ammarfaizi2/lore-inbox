Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRCBOIK>; Fri, 2 Mar 2001 09:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129167AbRCBOIA>; Fri, 2 Mar 2001 09:08:00 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:32999 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129166AbRCBOHq>; Fri, 2 Mar 2001 09:07:46 -0500
Message-ID: <3A9FA81C.1570696D@coplanar.net>
Date: Fri, 02 Mar 2001 09:03:08 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: Eduard Hasenleithner <eduardh@aon.at>, linux-kernel@vger.kernel.org
Subject: Re: How to set hdparms for ide-scsi devices on devfs?
In-Reply-To: <20010228224850.A10608@moserv.hasi> <Pine.LNX.4.10.10103010310070.6914-100000@master.linux-ide.org> <20010302094854.A19782@moserv.hasi> <20010302070827.A5772@animx.eu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:

> > PS: Is there still a possibility for setting the IDE-sleep timeout
> >       for a ide-scsi harddisk?  (I know, this doesnt make sense)

Yeah, why would you ?   ide-scsi is mainly to support cd-rw
drives, AFAIK

>
>
> I didn't know you could use ide-scsi emulation for hard drives.
>
> --
>  Lab tests show that use of micro$oft causes cancer in lab animals
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

