Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293407AbSCEQSK>; Tue, 5 Mar 2002 11:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293409AbSCEQSA>; Tue, 5 Mar 2002 11:18:00 -0500
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:26891 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S293407AbSCEQRr>; Tue, 5 Mar 2002 11:17:47 -0500
Message-Id: <200203051612.g25GCtc23752@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Greg KH <greg@kroah.com>, Carl-Johan Kjellander <carljohan@kjellander.com>
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
Date: Tue, 5 Mar 2002 11:45:25 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C8419FF.10103@kjellander.com> <20020305051146.GA7075@kroah.com>
In-Reply-To: <20020305051146.GA7075@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. März 2002 06:11 schrieb Greg KH:
> On Tue, Mar 05, 2002 at 02:06:07AM +0100, Carl-Johan Kjellander wrote:
> > Attached to each one of these is an Philips ToUCam pro which uses the pwc
> > and pwcx modules. (yes, the kernel becomes tainted by the pwcx module)
>
> As you are using this closed source module, I suggest you take this up
> with that module's author.

Perhaps you could first ask whether the hang can be reproduced
without that module loaded ?
Secondly, that module is unlikely to cause that kind of trouble.

	Regards
		Oliver
