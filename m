Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVAMAuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVAMAuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVAMArJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:47:09 -0500
Received: from mail.joq.us ([67.65.12.105]:24495 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261450AbVAMAnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:43:55 -0500
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Lee Revell <rlrevell@joe-job.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	<200501112251.j0BMp9iZ006964@localhost.localdomain>
	<20050111150556.S10567@build.pdx.osdl.net>
	<87y8ezzake.fsf@sulphur.joq.us>
	<20050112074906.GB5735@devserv.devel.redhat.com>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 12 Jan 2005 18:44:23 -0600
In-Reply-To: <20050112074906.GB5735@devserv.devel.redhat.com> (Arjan van de
 Ven's message of "Wed, 12 Jan 2005 08:49:06 +0100")
Message-ID: <87oefuma3c.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Tue, Jan 11, 2005 at 07:43:29PM -0600, Jack O'Quin wrote:
>> Lexicographic ambiguity: Lee and Paul are using "trash" for things
>> like installing a hidden suid root shell or co-opting sendmail into an
>> open spam relay.  Arjan just means crashing the system which forces
>> reboot to run fsck.
>
> I actually meant data corruption.

Are you concerned about something different from the "normal" risk of
data corruption when the kernel panics or someone trips over the power
cord?
-- 
  joq
