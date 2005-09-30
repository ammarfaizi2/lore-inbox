Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVI3PK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVI3PK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVI3PK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:10:58 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:12011 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030331AbVI3PK5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:10:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YHaSUMoDOS8wtdMAC1are2IJsJAK9yqDK6QaKp05TZBDZ5Pf4HC7rksWLlQgiXVSFqE3SDVFcNXt0h5kdPSRv1gwII3ObPelgs4he8NHipxMujeSu0buerGkhiuFzCU5m9BYIFGjxXBX362kvm2bzBLc53ix93KJkPnxtE9/qEI=
Message-ID: <4489a22a0509300810y723e5ef5tb9109a29508a1e38@mail.gmail.com>
Date: Fri, 30 Sep 2005 10:10:57 -0500
From: Alberto Patino <pato.lukaz@gmail.com>
Reply-To: Alberto Patino <pato.lukaz@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Cc: Oliver Neukum <oliver@neukum.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <433D447E.9030103@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <433BC9E9.6050907@pobox.com>
	 <7virwjegb5.fsf@assigned-by-dhcp.cox.net> <433D1E5D.20303@pobox.com>
	 <200509301402.46740.oliver@neukum.org> <433D447E.9030103@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Oliver Neukum wrote:
> >
> > The error is still there.
> >
> > oliver@oenone:~/linux-2.6> git checkout -f master
> > usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])
>
> Something's wrong with your installation, not the instructions.  Works
> fine here.
>

Right , you must have a corrupted copy of the git repo. Do the initial
cloning of the linux repository again, and then retry the git
checkout.
