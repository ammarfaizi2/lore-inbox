Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272158AbRJBLsv>; Tue, 2 Oct 2001 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272280AbRJBLsl>; Tue, 2 Oct 2001 07:48:41 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:53155 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S272158AbRJBLse> convert rfc822-to-8bit; Tue, 2 Oct 2001 07:48:34 -0400
Subject: Re: aic7xxx error
From: Stephane Dudzinski <stephane@antefacto.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0110021307130.2265-100000@pc40.e18.physik.tu-muenchen.de>
In-Reply-To: <Pine.LNX.4.31.0110021307130.2265-100000@pc40.e18.physik.tu-muenchen.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13 (Preview Release)
Date: 02 Oct 2001 12:45:18 +0100
Message-Id: <1002023119.29779.34.camel@steph>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Definitly hardware related, one of your hdds is beginning to die. Backup
is the next step·

On Tue, 2001-10-02 at 12:44, Roland Kuhn wrote:
>  I/O error: dev 08:61, sector 10180768
> SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
> Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
>  I/O error: dev 08:61, sector 10180520
> SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
> Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
>  I/O error: dev 08:61, sector 10180272
> SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
> Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
>  I/O error: dev 08:61, sector 10180024
> SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
> Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
>  I/O error: dev 08:61, sector 10179776


