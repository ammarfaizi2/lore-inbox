Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVGKQr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVGKQr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVGKQpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:45:15 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:14791 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262141AbVGKQny convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:43:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t9fY3LXwvnNKomn9/qoTkDVl2GVPbNJGPouhY9dfBcrPUQBi8awDOLMi77M2SJUOcVmAvhfg7jOYryBaDqH732WwaFEcf/aAT73HOeIDlcMIJOAaDNt+O/hkpESOLmlgRNHyuJOAuUTVSZeKDdQm10wtGxGViIyvhh6E9VEoQeU=
Message-ID: <f95c1df10507110943756eb894@mail.gmail.com>
Date: Mon, 11 Jul 2005 09:43:15 -0700
From: Jon Florence <jonflo@gmail.com>
Reply-To: Jon Florence <jonflo@gmail.com>
To: Douglas McNaught <doug@mcnaught.org>
Subject: Re: Swapping broken on 2.6.9? Limit Page Cache growth?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2ll4ds9jn.fsf@Douglas-McNaughts-Powerbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f95c1df1050710234275d52cad@mail.gmail.com>
	 <m2ll4ds9jn.fsf@Douglas-McNaughts-Powerbook.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes but I was having the same problems when I ran the tests on stock
2.6.10 & 2.6.11 kernels so it isnt limited to redhat only.



On 7/11/05, Douglas McNaught <doug@mcnaught.org> wrote:
> Jon Florence <jonflo@gmail.com> writes:
> 
> > Hi,
> > I have got a box running  2.6.9-1.667smp (FC3)
> 
> That's a Red Hat kernel so you should take it up with them, not the
> LKML.
> 
> -Doug
>
