Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269833AbTGKJAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269834AbTGKJAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:00:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40374
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269833AbTGKJAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:00:47 -0400
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Henrique Oliveira <henrique2.gobbi@cyclades.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Kevin Curtis <kevin.curtis@farsite.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <003101c34712$a9b8f480$602fa8c0@henrique>
References: <7C078C66B7752B438B88E11E5E20E72E25C978@GENERAL.farsite.co.uk>
	 <Pine.LNX.4.55L.0307101410570.25103@freak.distro.conectiva>
	 <003101c34712$a9b8f480$602fa8c0@henrique>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057914760.8028.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 10:12:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-10 at 19:39, Henrique Oliveira wrote:
> Hi,
> The patch for the generic HDLC layer was included on the kernel 2.4.21. Thus
> this layer is already on the main tree (unless, of course, someone has
> removed it, I havent checked 2.4.22 yet). This layer provides data link
> protocol (ppp, hdlc, raw-hdlc, x25, frame-relay, cisco-hdlc) for the kernel.
> It's mainly used by synchronous cards drivers (Cyclades, Moxa, SDL, Farsite,
> etc, etc, etc).

2.4.21 has much older code than the current stuff (which has been in -ac
for a while). As I understand it the new hdlc layer needs newer tools ?

