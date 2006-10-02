Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWJBMVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWJBMVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 08:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWJBMVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 08:21:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:21076 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932180AbWJBMVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 08:21:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cqKCJejS94yKxbBp/TVeF3u9EIhxW9EoEemDaZ1wjVMUHDLtwkwJNWIxurfaVi6gN3QzC6JMeCqnkogdM3TW7kJyLUkjEKsBZhSuj58Z5Tswey4jbu2oH0u9cHomUnkwY0Q+W8GT1+ggGDGa3CKDbHh+7x/BiLkU1tA1Go3amas=
Message-ID: <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com>
Date: Mon, 2 Oct 2006 12:21:35 +0000
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Norbert Preining" <preining@logic.at>
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Cc: hostap@shmoo.com, ipw3945-devel@lists.sourceforge.net,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061002113259.GA8295@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	 <20061002113259.GA8295@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/06, Norbert Preining <preining@logic.at> wrote:
> On Mon, 02 Okt 2006, Alessandro Suardi wrote:
> >  we've been just through an email thread where it has been
> >  determined that wpa_supplicant 0.4.9 (I would assume that
> >  0.5.5 is also okay) and wireless-tools from Jean's latest
> >  tarball are necessary to work with the recent wireless
> >  extensions v21 that have been merged in.
> >
> > What wireless-tools are you using ?
>
> wireless-tools from Debian/unstable, version 28-1, so I assume wireless
> v28. And the README tells the same. What would be the newest version?

http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/wireless_tools.29.pre10.tar.gz

 which, from Jean's page, has the following:

The main features of the latest beta is WE-21 support (long/short
retry, power saving level, modulation), enhanced command line parser
in iwconfig, scanning options, more WPA support and more footprint
reduction tricks


Cheers,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
