Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSGJOPL>; Wed, 10 Jul 2002 10:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSGJOPK>; Wed, 10 Jul 2002 10:15:10 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:13738 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S315440AbSGJOPK>; Wed, 10 Jul 2002 10:15:10 -0400
Date: Wed, 10 Jul 2002 17:21:25 +0300
From: Anssi Saari <as@sci.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATAPI + cdwriter problem
Message-ID: <20020710142125.GA27298@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20020709195437.GA1834@sci.fi> <E17S1c3-0005eu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17S1c3-0005eu-00@the-village.bc.nu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 09:29:31PM +0100, Alan Cox wrote:
 
> If you are having PDC202xx problems do try the patch Hank posted recently.
> It disables the raid controllers which is something we need to discuss in
> more detail to do in a better way but the rest of it is what Promise believe
> fixes the other problems - and it would benefit from much testing

Does "recently" mean about four months ago, for 2.4.18? How would a
2.4.18 with that patch compare to 2.4.19-pre10-ac2 which I'm running now?
