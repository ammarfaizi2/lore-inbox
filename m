Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVFNNlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFNNlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 09:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVFNNlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 09:41:36 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:47300 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261202AbVFNNlf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 09:41:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N2udiavgJAeqTVb2G9sQ0/Fu4CXT9TgZZW29056j3og3sC0f0nBuZgfk6pK4dbz7WkkLTF5Mib8le7ifjdplXAhQ8C7QuFZbm2q+gcjiJ3dW/yAARQsg2c1dndJenHm/RUkdli04XvXxx4HdiAJY8XDhJTn3jcFzr+lVEvchiOg=
Message-ID: <9e473391050614064111451333@mail.gmail.com>
Date: Tue, 14 Jun 2005 09:41:34 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: Input sysbsystema and hotplug
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-hotplug-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050614063851.GA19620@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506131607.51736.dtor_core@ameritech.net>
	 <20050613221657.GB15381@suse.de>
	 <9e473391050613232170f57ea3@mail.gmail.com>
	 <20050614063851.GA19620@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/05, Greg KH <gregkh@suse.de> wrote:
> > > Yes, lots of people want class devices to have children.  Unfortunatly
> > > they don't provide patches with their requests :)
> >
> > I did, but you didn't like it.
> 
> Heh, yes, sorry, you did.
> 
> Hm, I don't even remember why I didn't like it anymore, last I remember,
> I think you got the parent reference counting correct, right?  Care to
> dig out the patch and send it again?

Check out the thread "event sequencing" in the hotplug group. 

-- 
Jon Smirl
jonsmirl@gmail.com
