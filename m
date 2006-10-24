Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWJXMaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWJXMaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWJXMaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:30:06 -0400
Received: from main.gmane.org ([80.91.229.2]:15249 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161025AbWJXMaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:30:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: PC speaker listed as input device
Date: Tue, 24 Oct 2006 12:16:50 +0000 (UTC)
Message-ID: <loom.20061024T141625-529@post.gmane.org>
References: <ae7121c60610231153g4a55968gf2da729c13c8f18b@mail.gmail.com> <c526a04b0610231422i8ed5432g71467ae26a99baa1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.6 (Mozilla/5.0 (X11; U; Linux i686; nl; rv:1.8.1) Gecko/20061003 Firefox/2.0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Adam Henley <adamazing <at> gmail.com> writes:
> On 23/10/06, Panagiotis Issaris <panagiotis <at> gmail.com> wrote:
> > Hi,
> >
> > While trying to get my Hauppauge's remote control working, I noticed that my
> > PC speaker is getting recognized as an input device. This seems very weird
> > to me, is there some logic behind this?
> 
> Simple, all speakers are microphones!
> (http://www.google.com/search?q=%22a+speaker+as+a+microphone%22)
> 
> Though I don't know the real reason for recognising a speaker as an
> input device, this could be a "logical" explanation :o)
It would be if it would be recognised as /dev/dsp4 or something... but
/dev/input/event4 makes it look like a mouse or keyboard which still
seems very weird and illogical to me :)

With friendly regards,
Takis


