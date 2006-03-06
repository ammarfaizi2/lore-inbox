Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWCFQPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWCFQPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWCFQPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:15:14 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:22034 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750868AbWCFQPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:15:13 -0500
Date: Mon, 6 Mar 2006 17:15:12 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Is that an acceptable interface change?
Message-ID: <20060306161512.GB23513@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20060306011757.GA21649@dspnet.fr.eu.org> <1141631568.4084.2.camel@laptopd505.fenrus.org> <20060306155021.GA23513@dspnet.fr.eu.org> <9a8748490603060755r55b3584bpf0a16451a57925b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490603060755r55b3584bpf0a16451a57925b5@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 04:55:02PM +0100, Jesper Juhl wrote:
> Userspace apps should not include kernel headers, period.
> So, userspace applications really shouldn't care.

Please excuse me if I'm a little dense here, but the kernel headers
_define_ the userspace-kernel interface.  If you don't have them or a
sanitized copy of them you just can't talk with the kernel at all.

  OG.
