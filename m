Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUAKAJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUAKAJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:09:07 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:63200 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S265715AbUAKAJD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:09:03 -0500
Date: Sun, 11 Jan 2004 01:08:40 +0100
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: (fwd) Re: [2.6.1-mm2] ALSA sound/core/pcm_lib.c:224: Unexpected hw_pointer value
Message-ID: <20040111000840.GB993@neon>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Organization: pearbough.net
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Axel Siebenwirth <axel@pearbough.net> -----

From: Axel Siebenwirth <axel@pearbough.net>
Subject: Re: [2.6.1-mm2] ALSA sound/core/pcm_lib.c:224: Unexpected hw_pointer value
To: Petri Koistinen <petri.koistinen@iki.fi>
Date: Sun, 11 Jan 2004 01:07:57 +0100
Organization: pearbough.net

Hi Petri!

On Sun, 11 Jan 2004, Petri Koistinen wrote:

> > this is a (problem) report about warnings I get from my alsa kernel driver.
> 
> > Modules Loaded         ide_cd cdrom nvidia
> 
> Do you see that problem if you don't load nvidia driver.

Yes. Just tried.

Just noticed that sound hangs for about a second only when I switch from X
server to virtual console.

Axel


____________________________________________________________________________
Axel Siebenwirth				      phone +49 3641 776807 |
Am Birnstiel 3			 		  axel at pearbough dot net |
07745 Jena								    |
Germany________________________________________________http://pearbough.net |

The good die young -- because they see it's no use living if you've got
to be good.
                -- John Barrymore
____________________________________________________________________________

----- End forwarded message -----
