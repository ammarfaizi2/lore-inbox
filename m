Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbRDWXG7>; Mon, 23 Apr 2001 19:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRDWXFx>; Mon, 23 Apr 2001 19:05:53 -0400
Received: from venus.Sun.COM ([192.9.25.5]:8669 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S132547AbRDWXFC>;
	Mon, 23 Apr 2001 19:05:02 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Chmouel Boudjnah <chmouel@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <331f336dfb.36dfb331f3@mysun.com>
Date: Tue, 24 Apr 2001 00:56:33 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: i810_audio broken?
X-Accept-Language: en
Content-Type: multipart/mixed; boundary="--4edd29ea36807c4f"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

----4edd29ea36807c4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

I tried that one to, got even worse,
with the -tcp -p 16001 and conigured xmms to use that one.

The funny thing is that when use start the esd server
it plays a fanfare and it sounds ok (maybe it's to
short to notice the buggy sound)

----- Original Message -----
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Tuesday, April 24, 2001 0:59 am
Subject: Re: i810_audio broken?

> Pawel Worach wrote:
> > 
> > Ok building mpg123 without eSound worked for me too,
> > so guess this is not a Linux kernel issue, sorry for this.
> > 
> > I tried the fstodell hack but it seems to be obsoluted.
> > Now it works without any tweaks.
> > 
> > eSound sux?
> 
> Are you guys running esd with any special arguments?
> 
> esd needs a special argument, -r RATE [iirc], in order to tell esd 
> thatit is dealing with a locked rate codec.
> 
> -- 
> Jeff Garzik      | The difference between America and England is that
> Building 1024    | the English think 100 miles is a long distance and
> MandrakeSoft     | the Americans think 100 years is a long time.
>                 |      (random fortune)
> 

----4edd29ea36807c4f
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

----4edd29ea36807c4f--

