Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270625AbTGNMrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270631AbTGNMrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:47:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5058
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270646AbTGNMpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:45:40 -0400
Subject: Re: -- END OF BLOCK --
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, marcelo@conectiva.com,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.LNX.4.55L.0307140947210.18257@freak.distro.conectiva>
References: <200307141239.h6ECdqXP002766@hraefn.swansea.linux.org.uk>
	 <Pine.LNX.4.55L.0307140947210.18257@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058187405.606.65.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 13:56:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 13:50, Marcelo Tosatti wrote:
> > I've resynched -ac to the quota code in pre5 and added the automatic
> > quota loader on top again.
> 
> And the deadlock avoidance patches too right?
> 
> Would you mind sending me the automatic quota loader diff and the deadlock
> avoidance diff ?

The merge is non trivial. I'll let Christoph sort the mess out since I don't
have time to waste on it, and the old -ac quota code works perfectly well for
me.

