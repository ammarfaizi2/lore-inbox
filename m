Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTJ2OcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 09:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTJ2OcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 09:32:23 -0500
Received: from multiserv.relex.ru ([213.24.247.63]:27858 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S261471AbTJ2OcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 09:32:22 -0500
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI && vortex still broken in latest 2.4 and 2.6.0-test9
Date: Wed, 29 Oct 2003 18:32:22 +0300
User-Agent: KMail/1.5.4
References: <20031029134848.GA949@hello-penguin.com> <20031029140317.GF10693@merlin.emma.line.org>
In-Reply-To: <20031029140317.GF10693@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310291832.22650.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
On Wednesday 29 October 2003 17:03, Matthias Andree wrote:
> > Affected are at least
> > IBM Thinkpad T21  http://lkml.org/lkml/2003/6/15/111
> > IBM Thinkpad A21p (3c556B Laptop Hurricane)
>
> Might the problems you observe be related to the IBM BIOS?
Yes. With IBM's DSDT, to be more specific. I've filed a bug in the bugzilla, 
and tried to track it down, under careful guidance of Yu Luming, but general 
lack of time stops me from actively pursuing this target. 
Similar threads are appearing on this list regularly, and symptoms are very 
close to this bug, so I'm sure this will be fixed eventually (someone's 
comment about card not powering up (not entering D0) seems to be very close 
to the truth).

-- 
With all the best, yarick at relex dot ru.

