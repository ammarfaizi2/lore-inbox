Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbVHPBfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVHPBfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 21:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVHPBfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 21:35:20 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:53071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965067AbVHPBfT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 21:35:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pPM+7ZY6WkicegvwlGJ6TADteAmMAWw6ATm9F+nDpveDqgTZR0RD+VDLmJtxuvo+uksxZBMSBAXQwjXNeq4d+bivhAFEbrA7Eaj2GvmaRnYUXogPub0oXwQu0290390JiLmTa8N4PxPtfftdoBtrOERd5ycfA6L42JnF6sFEwac=
Message-ID: <bda6d13a050815183546210506@mail.gmail.com>
Date: Mon, 15 Aug 2005 18:35:18 -0700
From: Joshua Hudson <joshudson@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: BSD jail
In-Reply-To: <bda6d13a050814162519d6f2a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a050812174768154ea5@mail.gmail.com>
	 <20050813143335.GA5044@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <bda6d13a0508130933bdbc46a@mail.gmail.com>
	 <20050814115651.GA6024@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <bda6d13a050814162519d6f2a8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> To build a virtual network device requires code for the device, code
> for routing the device
> in the kernel, some way to tell the router that this machine is hosted
> through the host
> machine's ethernet card, and control of which processes use which
> network devices.
> 
I've bombed out. I don't understand how the network devices work well
enough to do any of this.
