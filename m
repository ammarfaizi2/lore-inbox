Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267964AbRGXQsL>; Tue, 24 Jul 2001 12:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267982AbRGXQsC>; Tue, 24 Jul 2001 12:48:02 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:64778 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S267964AbRGXQrm>;
	Tue, 24 Jul 2001 12:47:42 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Allen Campbell <lkml@campbell.cwx.net>
Date: Tue, 24 Jul 2001 18:47:21 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: FYI: vmware breakage w/2.4.7
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <98F62A10589@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 23 Jul 01 at 16:35, Allen Campbell wrote:
> 2.4.7 appears to break vmware (latest build: 1142.)  Looks like some
> #defines moved. The vmmon build produces the following noise:
> 
> Doubtless were looking at the result of an inappropriate dependency on
> the part of vmware.  I'm not expecting any sort of help or fix.  This
> is just an FYI for those that need to emulate windows.

Patch exists since friday and it was already discussed on linux-kernel.
You should refresh your vmmon.tar and vmnet.tar with:

ftp://platan.vc.cvut.cz/pub/vmware/vmmon-for-2.4.7-only.tar.gz
ftp://platan.vc.cvut.cz/pub/vmware/vmnet-204-for-2.4.6.tar.gz

                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
