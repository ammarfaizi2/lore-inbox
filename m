Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129097AbQKWWAo>; Thu, 23 Nov 2000 17:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129295AbQKWWAe>; Thu, 23 Nov 2000 17:00:34 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:49424 "EHLO zikova.cvut.cz")
        by vger.kernel.org with ESMTP id <S129097AbQKWWAV>;
        Thu, 23 Nov 2000 17:00:21 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 23 Nov 2000 22:29:50 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: VMWare will not run on kernel 2.4.0-test11
CC: linux-kernel@vger.kernel.org (Linux-KERNEL)
X-mailer: Pegasus Mail v3.40
Message-ID: <DB4EB260F6F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Nov 00 at 20:22, Alan Cox wrote:
> > vmware-2.0.3-786 refused to run.  Running vmware-config.pl resulted in a
> > the following message:
> 
> Run 2.4.0-test11-ac3

Hi Alan,
  is change to field name temporary, and name will be reverted back
to flags, even although contents may differ between 2.2.x and 2.4.x,
or is there features to stay? Currently VMware does

"^\(features\|flags\).* tsc"

but question is - should we leave it here, or revert it back?

  BTW, as I told couple of times here, if you have problem with VMware
on 2.3.x/2.4.x kernel, please first visit news server news.vmware.com
and look into vmware.for-linux.experimental newsgroup. If you'll not
find fix/workaround here (this one is there since Tigran pointed it to
me more than week ago - Nov 15, 02:59 CET), post question to that forum. 
I watch that newsgroup almost continuously during my working hours (that 
is aprox. 12:00-24:00 CET Mon-Fri).
                                            Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
