Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264909AbRFZMmZ>; Tue, 26 Jun 2001 08:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbRFZMmP>; Tue, 26 Jun 2001 08:42:15 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:58637 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S264851AbRFZMl6>; Tue, 26 Jun 2001 08:41:58 -0400
Message-ID: <3B388312.582066D9@delusion.de>
Date: Tue, 26 Jun 2001 14:41:54 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tvmixer Oops
In-Reply-To: <20010626133925.A6890@bytesex.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gerd Knorr wrote:
> 
> On Mon, Jun 25, 2001 at 12:56:03PM +0200, Udo A. Steinberg wrote:

> > Attached is the trace of an oops which seems to be caused by the
> > tvmixer code. Tvmixer is compiled monolithically into the kernel,
> > the rest of bttv is compiled as modules.
> 
> Any hints on how to reproduce that one?

I cannot reproduce it again - it happened just once so far. The time
it happened, I zapped X/KDE while xawtv ran via Ctrl-Alt-Backspace.
