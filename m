Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVGGHN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVGGHN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 03:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVGGHN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 03:13:28 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:47963 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261206AbVGGHN1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 03:13:27 -0400
Date: Thu, 7 Jul 2005 11:16:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fedora core 3 Version magic error..
Message-ID: <20050707091643.GA8053@mars.ravnborg.org>
References: <4EE0CBA31942E547B99B3D4BFAB34811610712@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811610712@mail.esn.co.in>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 12:12:12PM +0530, Mukund JB. wrote:
> Dear all,
> ?
> I have a problem loading the rpm build locally on Fedora core 3, linux kernel 2.6.10.
> ?
> After building the rpm file from the available sources on the Linux kernel 2.6.10 which was D/W from kernel.org and build, I am unable to load it.
> ?
> It results in the following errors:-
> tifm: version magic '2.6.10 686 REGPARM gcc-3.3' should be '2.6.10 REGPARM gcc-3.4'
> ?
Looks like you did not compile the tifm module with latest compiler.

	Sam
