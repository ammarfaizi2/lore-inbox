Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbUAELCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 06:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUAELCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 06:02:04 -0500
Received: from [212.28.208.94] ([212.28.208.94]:19721 "HELO dewire.com")
	by vger.kernel.org with SMTP id S264142AbUAELCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 06:02:01 -0500
From: Robin Rosenberg <roro.l@dewire.com>
To: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Date: Mon, 5 Jan 2004 12:01:58 +0100
User-Agent: KMail/1.5.3
References: <20040103040013.A3100@pclin040.win.tue.nl> <m31xqedelx.fsf@lugabout.jhcloos.org> <1073288725.2385.70.camel@laptop-linux>
In-Reply-To: <1073288725.2385.70.camel@laptop-linux>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401051201.58356.roro.l@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

måndagen den 5 januari 2004 08.45 skrev Nigel Cunningham:
> Hi.
>
> On Mon, 2004-01-05 at 20:44, James H. Cloos Jr. wrote:
> > >>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:
> >
> > Linus> Why? Becuase that _program_ sure as hell isn't
> > Linus> running across a reboot.
> >
> > Is that strictly true?  With (software) suspend to disk,
> > will the old device enumeration data be recovered from
> > the suspend partition?
>
> Yes. You end up running the original kernel.

But not necessarily the same devices.

> Regards,
>
> Nigel

-- rob in

