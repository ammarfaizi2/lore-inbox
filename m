Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273046AbRIIVCe>; Sun, 9 Sep 2001 17:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273049AbRIIVCO>; Sun, 9 Sep 2001 17:02:14 -0400
Received: from t2.redhat.com ([199.183.24.243]:9457 "EHLO
	toomuch.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S273046AbRIIVBz>; Sun, 9 Sep 2001 17:01:55 -0400
Date: Sun, 9 Sep 2001 17:02:06 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
Message-ID: <20010909170206.A3245@redhat.com>
In-Reply-To: <20010909220921.A19145@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010909220921.A19145@bug.ucw.cz>; from pavel@suse.cz on Sun, Sep 09, 2001 at 10:09:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Sep 09, 2001 at 10:09:21PM +0200, Pavel Machek wrote:

> and send results to me? It should be rather easy to emulate initial
> handshake and use mars (netware emulator) to boot workstation...

No need -- just search around for a copy of rpld.  I've got a few 
SiS based boards that netboot via rpl which rpld manages to handle 
like a charm.  Cheers,

		-ben
