Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWGaWq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWGaWq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWGaWqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:46:25 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:34479 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030359AbWGaWqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:46:24 -0400
Message-ID: <44CE883C.8090206@oracle.com>
Date: Mon, 31 Jul 2006 15:46:20 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Ulrich Drepper <drepper@redhat.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru> <44C930D5.9020704@oracle.com> <20060728052312.GB11210@2ka.mipt.ru> <44CA586C.4010205@oracle.com> <20060728184445.GA10797@2ka.mipt.ru> <44CA613F.9080806@oracle.com> <44CAD81A.9060401@redhat.com> <20060729154401.GA25926@2ka.mipt.ru> <44CB8A67.3060801@redhat.com> <20060731103322.GA1898@2ka.mipt.ru>
In-Reply-To: <20060731103322.GA1898@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, let's do it in the following way:
> I present new version of kevent with new syscalls and fixed issues mentioned
> before, while people look at it we can end up with mapped buffer design.
> Is it ok?

Yeah, that sounds good.  I'm looking forward to seeing the next set of
patches :).

- z
