Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUCPTsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUCPTsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:48:38 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:37827 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261533AbUCPTl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:41:58 -0500
Date: Tue, 16 Mar 2004 20:41:54 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: rmk@arm.linux.org.uk,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: TLD.rmk.(none) junk in BitKeeper logs where BK_HOST belongs?
Message-ID: <20040316194153.GA15282@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	rmk@arm.linux.org.uk,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040316184455.GA31710@merlin.emma.line.org> <20040316191454.GK17813@bitmover.com> <Pine.LNX.4.58.0403161132000.17272@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403161132000.17272@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004, Linus Torvalds wrote:

> He does it on purpose. Apparently there is some UK law that may make it 
> illegal to export other peoples email addresses without express consent, 
> so rmk corrupts them with a script..

Two notes:
1.
This could be handled by only including patches of those people who
consent to their address being published,

2.
The user does not have to give a routable mail address in
BK_USER/BK_HOST, but he can set BK_HOST to whatever he wants.


If the whole corruption is intentional, then I'd suggest that RMK
participates in the maintenance of the lk-changelog.pl aka. shortlog
script. I have no chance to resolve common names through
google/lbdb/grep -r on the suspect source files unless the address is
there. There are so many people called Jonas Larsson - how do I know if
that fellow has a middle name?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
