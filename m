Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTI0P6d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 11:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTI0P6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 11:58:33 -0400
Received: from [65.248.106.250] ([65.248.106.250]:22718 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S262525AbTI0P6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 11:58:31 -0400
From: Brian Jackson <brian@brianandsara.net>
To: Michael Pyne <pynm0001@unf.edu>, linux-kernel@vger.kernel.org
Subject: Re: Bug report: intel8x0 sound
Date: Sat, 27 Sep 2003 11:00:31 -0500
User-Agent: KMail/1.5.4
References: <200309270107.19516.pynm0001@unf.edu>
In-Reply-To: <200309270107.19516.pynm0001@unf.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309271100.31104.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 September 2003 12:06 am, Michael Pyne wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> There is a problem with sound using the ALSA intel8x0 driver, which causes 
the 
> rate of audio playback to fluctuate in speed.  This SEEMS to be trigged 
every 
> time by using alsamixer to unmute the "Digital Audio Mode" setting, but I've 
> also had it happen all of a sudden.

FWIW I can confirm that I have also seen this behavior.

--Brian Jackson

<snip>

