Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSGODby>; Sun, 14 Jul 2002 23:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSGODbx>; Sun, 14 Jul 2002 23:31:53 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:21969 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317299AbSGODbx>; Sun, 14 Jul 2002 23:31:53 -0400
Date: Sun, 14 Jul 2002 23:34:40 -0400
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714233440.A21612@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	Thunder from the hill <thunder@ngforever.de>,
	linux-kernel@vger.kernel.org
References: <xlt1ya6j746.fsf@shookay.newview.com> <Pine.LNX.4.44.0207141613440.3452-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207141613440.3452-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Sun, Jul 14, 2002 at 04:14:35PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 04:14:35PM -0600, Thunder from the hill wrote:
> Hi,

  Hi,
 
> On 14 Jul 2002, Mathieu Chouquet-Stringer wrote:
> > mchouque - /tmp/joerg %/usr/bin/time tar jxf rock.tar.bz2
> > 19.69user 6796.49system 1:56:05elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (319major+951minor)pagefaults 0swaps
> > /usr/bin/time tar jxf rock.tar.bz2  19.69s user 6796.49s system 97% cpu 1:56:05.11 total
> 
> Impressive. Did the interval between file writes get longer as time 
> passed?

Well, I don't really know but I guess so (I ran tar without the verbose
switch, would there be another way to see this? I guess stracing should do
it but it adds such an overhead I don't think that's such a good idea).
Anyway, I'm going to erase this nice directory now...
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
