Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTESVYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTESVYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:24:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3893 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263077AbTESVYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:24:51 -0400
Date: Mon, 19 May 2003 21:37:45 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>,
       David Ford <david+cert@blue-labs.org>,
       Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519213745.N7061@devserv.devel.redhat.com>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519124539.B8868@infradead.org> <3EC91B6D.9070308@blue-labs.org> <1053367592.1424.8.camel@laptop.fenrus.com> <20030519213530.GB1069@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030519213530.GB1069@mars.ravnborg.org>; from sam@ravnborg.org on Mon, May 19, 2003 at 11:35:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 11:35:30PM +0200, Sam Ravnborg wrote:
> On Mon, May 19, 2003 at 08:06:32PM +0200, Arjan van de Ven wrote:
> > 
> > I maintain such a subset for my employer and it's free for all to use
> > (it's GPL after all). 
> 
> 
> Do you have other tools, except good judment to help you in the process?
> Some perl scripts or other goodies maybe.

there is unifdef floating around that I'm going to use from now on ;)
(I just recently found it somewhere, google for it)
