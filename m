Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSBUWfw>; Thu, 21 Feb 2002 17:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285226AbSBUWfo>; Thu, 21 Feb 2002 17:35:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:6345 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285073AbSBUWfY>;
	Thu, 21 Feb 2002 17:35:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Compile error with linux-2.5.5-pre1 & advansys scsi
Date: Thu, 21 Feb 2002 23:37:09 +0100
X-Mailer: KMail [version 1.3.9]
In-Reply-To: <3C6C579F.960DE0D7@torque.net>
In-Reply-To: <3C6C579F.960DE0D7@torque.net>
Cc: linux-scsi@vger.kernel.org, dougg@torque.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200202212336.33831.gjwucherpfennig@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 February 2002 01:34, Douglas Gilbert wrote:
> "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net> wrote:
> > The advansys scsi driver of linux-2.5.5-pre1 doesn't compile ...
>
> Gerold,
> Please try the attachment, tested on i386 UP + SMP.
>
> Doug Gilbert

This patch works very well for me and it's a pitty that it wasn't included
into Kernel 2.5.5-final.

I'm using advansys scsi with my P2 UP (Intel LX).

It should be included into Dave Jones tree (or is it already?),
because Linus seems to be very busy (as usual).

Gerold J. Wucherpfennig
