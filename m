Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135324AbRAKWq1>; Thu, 11 Jan 2001 17:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132957AbRAKWqS>; Thu, 11 Jan 2001 17:46:18 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:55045 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S132628AbRAKWqH>; Thu, 11 Jan 2001 17:46:07 -0500
Message-ID: <3A5E37B3.233B9C03@Hell.WH8.TU-Dresden.De>
Date: Thu, 11 Jan 2001 23:46:11 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <UTC200101112234.XAA98877.aeb@ark.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> These days umount is done by directory, not by device,
> since a device may be mounted multiple times, so
> I expect the silly message is gone.
> (Is your umount recent?)
> 
> [But this is only about the "none". I don't know what is
> wrong in your situation.]

My umount is 2.10r. Alan says he knows what is wrong,
so we're all curiously expecting -ac7 ;)

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
