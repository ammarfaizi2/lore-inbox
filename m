Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132527AbRDWWue>; Mon, 23 Apr 2001 18:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132516AbRDWWs6>; Mon, 23 Apr 2001 18:48:58 -0400
Received: from venus.Sun.COM ([192.9.25.5]:5334 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S132511AbRDWWrv>;
	Mon, 23 Apr 2001 18:47:51 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <3829d3430e.3430e3829d@mysun.com>
Date: Tue, 24 Apr 2001 00:39:23 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: i810_audio broken?
X-Accept-Language: en
Content-Type: multipart/mixed; boundary="--aea49455cd24094"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

----aea49455cd24094
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Ok building mpg123 without eSound worked for me too,
so guess this is not a Linux kernel issue, sorry for this.

I tried the fstodell hack but it seems to be obsoluted.
Now it works without any tweaks.

eSound sux?

Thanks guys!
Back to work (with music :)

----- Original Message -----
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: Tuesday, April 24, 2001 1:34 am
Subject: Re: i810_audio broken?

> "Pawel Worach" <pworach@mysun.com> writes:
> 
> > I was using mpg123 (xmms and c/o does exactly the same)
> > if I run it like this Moby sounds very stupid... :)
> 
> i got the same problem when using mpg123 compiled with esd on my dell
> workstation (which has a need to have set explictely to a clocking of
> 41194 via ftsodell option), compiling without esd seems fix the prob
> for me.
> 
> -- 
> Chmouel
> 

----aea49455cd24094
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

----aea49455cd24094--

