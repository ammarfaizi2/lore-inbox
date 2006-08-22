Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWHVOjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWHVOjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWHVOjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:39:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:4658 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932274AbWHVOjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:39:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A1lhvzPNAFI70SPZqljvz8FQmIZqJPLy16n3bbPTmqdBgVf/AKjeG5DXaWKQmL3mXkGeE2bbqgcoQmlY82yIWoWs+x7xc3pXEqEZSZckLuMB8vAVdqYtuCTEPTmWARt6r2X/zteW9sAnxS0MNH1qn1I5ZSx5fmLFHov/6vgdl0s=
Message-ID: <625fc13d0608220739n18cd971s4a236b55724c0a85@mail.gmail.com>
Date: Tue, 22 Aug 2006 09:39:10 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: 2.6.18-rc4 jffs2 problems
Cc: "Greg KH" <greg@kroah.com>, "Richard Purdie" <rpurdie@rpsys.net>,
       linux-mtd <linux-mtd@lists.infradead.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1156255936.29825.15.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1154976111.17725.8.camel@localhost.localdomain>
	 <1155852587.5530.30.camel@localhost.localdomain>
	 <625fc13d0608191834r19ce12e5raccbae011d67c25e@mail.gmail.com>
	 <20060821013545.GA21012@kroah.com>
	 <1156255936.29825.15.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Sun, 2006-08-20 at 18:35 -0700, Greg KH wrote:
> > Add what to what tree?  I need things to be a bit more specific
> > here :)
>
> I think he means the tree you were keeping while Linus was away. I'll
> sort out this and one or two more to send to Linus shortly.

Yeah, I did.  Sorry, I can see how that was confusing.  Richard was
kind enough to follow up by sending the patch directly to Greg.

josh
