Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751743AbWJERmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbWJERmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbWJERmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:42:43 -0400
Received: from codepoet.org ([166.70.99.138]:42121 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1751742AbWJERmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:42:42 -0400
Date: Thu, 5 Oct 2006 11:42:41 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061005174241.GA23632@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <20061003231648.GB26351@thunk.org> <1159948179.2817.26.camel@ux156> <20061005163513.GC6510@bougret.hpl.hp.com> <4525364D.1000409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4525364D.1000409@garzik.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 05, 2006 at 12:43:57PM -0400, Jeff Garzik wrote:
> Wireless Extensions has reached end-of-life, and so we only need to
> support what's out there in wide distribution.

Hmm, so what is going to replace it?  I was messing about with my
old powerbook G4 titanium, trying to make wpa_supplicant work
when I realized the airport/orinoco driver used for my powerbook
can't handle WPA since that apparently requires at least WE-18.
I started looking into what it would take to teach the orinoco
driver about WE>=18.  But I suppose there is no point in my
looking further if WE is heading to the great bit-bucket in the
sky.

Is 'Wireless Extensions The Next Generation' described and
documented somewhere?  Or am I better off if I just give up and
move on to some other more realistic project?  :-)

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
