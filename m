Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278316AbRJWV4s>; Tue, 23 Oct 2001 17:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278317AbRJWV4i>; Tue, 23 Oct 2001 17:56:38 -0400
Received: from blue.gradwell.net ([195.149.39.10]:38594 "HELO
	blue.gradwell.net") by vger.kernel.org with SMTP id <S278316AbRJWV41>;
	Tue, 23 Oct 2001 17:56:27 -0400
Date: Tue, 23 Oct 2001 22:58:35 +0100
From: Peter Hamilton <lobsterphoneuk@yahoo.co.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.12: High disk activity + system load causes lockup
Message-ID: <20011023225835.A3464@hamil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding:
  2.4.12: High disk activity + system load causes lockup.

On Mon, 22 Oct 2001 17:40:47 Marcelo Tosatti wrote:
> Pete,
> 
> Please try to reproduce the problem without the Nvidia driver loaded.

I can confirm that the system locks up reliably without the Nvidia
driver.  This time I was doing a "mke2fs /dev/hda9" to create a
1Gb junk partition for testing this very problem :-)  The system
died when it reached the "Writing superblocks...:" stage.

Back to 2.4.6 at the moment.

I'm not subscribed to this list, so please Cc: if you want me to
see replies - thanks.

All the best, Pete.

