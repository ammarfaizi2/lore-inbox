Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTGCN5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 09:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTGCN5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 09:57:11 -0400
Received: from village.ehouse.ru ([193.111.92.18]:61450 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S263201AbTGCN5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 09:57:08 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Oleg Drokin <green@namesys.com>
Subject: Re: high system usage with kmail in 2.5.7X
Date: Thu, 3 Jul 2003 18:11:33 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307031637.46227.rathamahata@php4.ru> <20030703124947.GA819@namesys.com> <200307031802.40009.rathamahata@php4.ru>
In-Reply-To: <200307031802.40009.rathamahata@php4.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307031811.33408.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 July 2003 18:02, Sergey S. Kostyliov wrote:
> On Thursday 03 July 2003 16:49, Oleg Drokin wrote:
> > Hello!
> >
> > On Thu, Jul 03, 2003 at 04:37:46PM +0400, Sergey S. Kostyliov wrote:
> > > I experienced an abnormally high system usage whith kmail
> > > (KDE mail client). This is usually happened when I click on a
> > > huge mail folder. Then kmail just stops responding for a dozens of
> > > seconds. Seems like problem started around 2.5.70 (2.5.69 doesn't
> > > compile on my box, 2.5.68 works fine for me).
> >
> > This is a kmail 3.0x problem (with large recommended i/o sizes), it is
> > reported that upgrading to kmail 3.1+ will help. Alternatively you can
> > mount your reiserfs volumes with "-o nolargeio=1"
>
> Yes I know about problem with kmail 3.0x, but in my case this is kmail
> 3.1.2. Anyway nolargeio=1 has solved this problem for me. Thanks for the
> help!
Err, kmail 1.5 bundled with kde 3.1.2

>
> > Bye,
> >     Oleg

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
