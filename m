Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbVIAUiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbVIAUiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVIAUiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:38:55 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:60 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030369AbVIAUiz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:38:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qqCqLqYqaXzyD9MPn4DF6NFxJz492OlwEHY046dY7pYBDWZ4L66rt40WRflIT1xWrbzXTWbWOH+QKRAA+pJivsnP07WT99eHw38IdQRSmwWQ+iqF43feNYehYvVvhLfZ6G111QgSZGqIWLrXtM1T8Qoh3mc0br4BkFcz0qFlWC4=
Message-ID: <9e47339105090113381222c9d0@mail.gmail.com>
Date: Thu, 1 Sep 2005 16:38:54 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: jg@freedesktop.org,
       Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Subject: Re: State of Linux graphics
Cc: Andreas Hauser <andy@splashground.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1125605907.10488.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43171D33.9020802@tungstengraphics.com>
	 <1125590374.9419.35.camel@localhost.localdomain>
	 <20050901163958.9589.qmail@paladin.fortunaty.net>
	 <1125605907.10488.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Jim Gettys <jg@freedesktop.org> wrote:
> Not at all.
> 
> We're pursuing two courses of action right now, that are not mutually
> exclusive.
> 
> Jon Smirl's argument is that we can satisfy both needs simultaneously
> with a GL only strategy, and that doing two is counter productive,
> primarily on available resource grounds.
> 
> My point is that I don't think the case has (yet) been made to put all
> eggs into that one basket, and that some of the arguments presented for
> that course of action don't hold together.

We're not putting all of our eggs in one basket, you keep forgetting
that we already have a server that supports all of the currently
existing hardware. The question is where do we want to put our future
eggs.

-- 
Jon Smirl
jonsmirl@gmail.com
