Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVKGG6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVKGG6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVKGG6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:58:05 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:27027 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964817AbVKGG6E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:58:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f/suk0BTGy7/pGp/WkFaDvs5EBXkmEHJ2M7STLJv4E2tqtcKrOGKgthISZhxyL19Ow8lp/JrkQI6WqMFIUCu4TdyPoV33LgEqUPMOkM/JN9qB4M5884DOs3ykPNzbPfMVBLb5mF12iEzEJTWJmIp70TVGtcZwuFV1RU/p2RQmdI=
Message-ID: <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
Date: Mon, 7 Nov 2005 14:58:03 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051104230644.GA20625@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	 <20051104230644.GA20625@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  But this patch only includes the arch files for Blackfin. Do I have
to break it into smaller chunks? It is hard to break it...

On 11/5/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Nov 04, 2005 at 12:59:14PM +0800, Luke Yang wrote:
> > Hi,
> >
> >   Does this patch has the chance to be merged? Is anyone reivewing or
> > merging it? Anything I can help? Just want to make sure... Thanks a
> > lot!
>
> Your patch is 43 thousand lines long.  Please break it up into the
> different logical chunks, and document them, and add a signed-off-by:
> line, and send them to the proper places/people, as it is documented in
> the file, Documentation/SubmittingPatches.
>
> thanks,
>
> greg k-h
>
