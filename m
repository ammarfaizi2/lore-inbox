Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbTHFP6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269676AbTHFP6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:58:35 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:10831 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S269747AbTHFP6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:58:31 -0400
Date: Wed, 6 Aug 2003 10:58:30 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Werner Almesberger <werner@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030806105830.B26920@hexapodia.org>
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net> <m1fzkiwnru.fsf@frodo.biederman.org> <20030804162433.L5798@almesberger.net> <m1u18wuinm.fsf@frodo.biederman.org> <20030806021304.E5798@almesberger.net> <m1llu7ushr.fsf@frodo.biederman.org> <20030806103758.H5798@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030806103758.H5798@almesberger.net>; from werner@almesberger.net on Wed, Aug 06, 2003 at 10:37:58AM -0300
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 10:37:58AM -0300, Werner Almesberger wrote:
> Eric W. Biederman wrote:
> > to keep your latency down.  Do any ethernet switches do cut-through?
> 
> According to Google, many at least claim to do this.

Do you have any references for this claim?  I have never seen one that
panned out (at least not since the high-end-10mbps days).

Just to be clear, I am asking for an example of a Gigabit Ethernet
switch that supports cut-through switching.  I contend that there is no
such beast commercially available today.

(It would be even more interesting if it could switch 9000-octet jumbo
frames, too.)

I'm sure someone is going to point me to a $10,000/port monster, and
while that's not very feasible for my needs, it would still be
interesting.

-andy
