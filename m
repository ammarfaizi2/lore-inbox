Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbRDWWjw>; Mon, 23 Apr 2001 18:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbRDWWjr>; Mon, 23 Apr 2001 18:39:47 -0400
Received: from venus.Sun.COM ([192.9.25.5]:20946 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S132718AbRDWWib>;
	Mon, 23 Apr 2001 18:38:31 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <386e136930.36930386e1@mysun.com>
Date: Tue, 24 Apr 2001 00:30:04 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: i810_audio broken?
X-Accept-Language: en
Content-Type: multipart/mixed; boundary="--209d176238e23773"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

----209d176238e23773
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

It sounds like when you play music very loud with bad speakers
and it's kind of slow. It's kind of "clinking", describing sound via
e-mail can be very hard.

what value shall i put for the clocking parameter?
is it trial-and-error or is there some formula?

And no, the cut off output does not mean that it worked. :(
xmms says this:
Audio device open for 44.1Khz, stereo, 8bit failed
Trying 48Khz, 16bit stereo.
But it still sounds strange.


----- Original Message -----
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Tuesday, April 24, 2001 0:07 am
Subject: Re: i810_audio broken?

> Pawel Worach wrote:
> > sorry the kernel version is 2.4.3-ac12, so it's kind of latest...
> > 
> > I was using mpg123 (xmms and c/o does exactly the same)
> > if I run it like this Moby sounds very stupid... :)
> 
> "very stupid" means "broken" obviously, but can you be more 
> specific? 
> music is faster? slower?  garbled?
> 
> > [root@whyami mp3]# mpg123 -r 48000 Moby_01.wav.mp3
> > unsupported playback rate: 44100
> > Audio device open for 44.1Khz, stereo, 16bit failed
> > Trying 44.1Khz, 8bit stereo.
> > unsupported sound format: 32
> > Audio device open for 44.1Khz, stereo, 8bit failed
> > Trying 48Khz, 16bit stereo.
> 
> so, since you provided no more output than this, I assume that
> 48Khz/16bit succeeded, which appears perfectly normal for a locked-
> ratecodec.
> 
> You may need the 'clocking' module option, not sure...
> 
> -- 
> Jeff Garzik      | The difference between America and England is that
> Building 1024    | the English think 100 miles is a long distance and
> MandrakeSoft     | the Americans think 100 years is a long time.
>                 |      (random fortune)
> 

----209d176238e23773
Content-Type: text/x-vcard; name="pworach.vcf"; charset=us-ascii
Content-Disposition: attachment; filename="pworach.vcf
Content-Description: Card for <pworach@mysun.com>
Content-Transfer-Encoding: 7bit

begin:vcard
n:Worach;Pawel
fn:Pawel Worach
version:2.1
email;internet:pawel.worach@mysun.com
end:vcard

----209d176238e23773--

