Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWBOTQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWBOTQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWBOTQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:16:43 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:57604 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S932166AbWBOTQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:16:42 -0500
To: Rob Landley <rob@landley.net>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
	<200602142155.03407.rob@landley.net>
	<20060215183115.GE29940@csclub.uwaterloo.ca>
	<200602151409.41523.rob@landley.net>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 15 Feb 2006 14:16:36 -0500
In-Reply-To: <200602151409.41523.rob@landley.net> (Rob Landley's message of
 "Wed, 15 Feb 2006 14:09:41 -0500")
Message-ID: <87k6bwl9ez.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> writes:

> On Wednesday 15 February 2006 1:31 pm, Lennart Sorensen wrote:
>> once.
>
> Yup.  Apparently with SAS, the controllers are far more likely to fail than 
> the drives.

I think the actual idea (or one of them) is to have two machines
connected to each drive, in a hot-standby configuration.  This has
been done for a long time with parallel SCSI, where both machines have
controllers on the bus.

-Doug
