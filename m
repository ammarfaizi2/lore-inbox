Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWJCTIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWJCTIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWJCTIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:08:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:51911 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030336AbWJCTIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:08:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oR8OHChcuUeJMRXdM/F3qHoLTpAtk2lGYK1jlllYR+4AyZ9r/tDhqr5d4Eb09At7q0JUHtYIRN3sACc3udHYjd9cckhYI7656bewMnpcQIlLMmzxr000wW6sEDRmujHQXlfTNosMb+PIxDHbg38qEcgJZfA4lM6JkZgZ9uLRDuY=
Message-ID: <d120d5000610031208i4a204b2es8de8d424a573acf4@mail.gmail.com>
Date: Tue, 3 Oct 2006 15:08:43 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: jt@hpl.hp.com
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Cc: "Jeff Garzik" <jeff@garzik.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Alessandro Suardi" <alessandro.suardi@gmail.com>,
       "Norbert Preining" <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
In-Reply-To: <20061003183849.GA17635@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	 <1159807483.4067.150.camel@mindpipe>
	 <20061003123835.GA23912@tuxdriver.com>
	 <1159890876.20801.65.camel@mindpipe>
	 <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
	 <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
	 <20061003183849.GA17635@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
>
>        Now it's too late, those changes have propagated to userspace
> tools, and are now shipping in some actual release of some distro. So,
> what are we going to say to Mandriva 2007 and FC6 users, to revert
> back to an *older* version of the tools ?
>        Because userspace has already been updated, we have only two
> options, merge it now, or in 2.6.20.
>

Are you saying that compatibility is broken both ways?? Not only one
needs new tools for the new kernels but also has to downgrade tools to
work with older kernels??

-- 
Dmitry
