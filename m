Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSGYAMX>; Wed, 24 Jul 2002 20:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318300AbSGYAMX>; Wed, 24 Jul 2002 20:12:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:46073 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318299AbSGYAMW>; Wed, 24 Jul 2002 20:12:22 -0400
Subject: Re: is flock broken in 2.4 or 2.5 kernels or what does this mean?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Ford <david+cert@blue-labs.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, John Covici <covici@ccs.covici.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D3ED0E4.9020902@blue-labs.org>
References: <m37kjmik0g.fsf@ccs.covici.com>
	<1027441872.31787.139.camel@irongate.swansea.linux.org.uk>
	<20020723214410.GA3249@werewolf.able.es>  <3D3ED0E4.9020902@blue-labs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 02:28:41 +0100
Message-Id: <1027560521.6456.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 17:08, David Ford wrote:
> (Alan)
> Actually I posted a "is sendmail on crack?" question last month when 
> 8.12.5 was released and this was in the release notes.  We got a bunch 
> of confirmations that Linux flock() was broken due to the accounting.

Thanks. I now have the original discussion, the demonstration and a
patch Andrea believes fixes it.

