Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270524AbTGXIkB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 04:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271156AbTGXIkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 04:40:01 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:61196 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270524AbTGXIkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 04:40:00 -0400
Date: Thu, 24 Jul 2003 09:55:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michal Semler <cijoml@volny.cz>
Cc: Martin Zwickel <martin.zwickel@technotrend.de>,
       linux-kernel@vger.kernel.org
Subject: Re: passing my own compiler options into linux kernel compiling
Message-ID: <20030724095505.A28118@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michal Semler <cijoml@volny.cz>,
	Martin Zwickel <martin.zwickel@technotrend.de>,
	linux-kernel@vger.kernel.org
References: <200307240916.17530.cijoml@volny.cz> <20030724100111.343d84cd.martin.zwickel@technotrend.de> <200307241050.25094.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307241050.25094.cijoml@volny.cz>; from cijoml@volny.cz on Thu, Jul 24, 2003 at 10:50:25AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 10:50:25AM +0200, Michal Semler wrote:
> Hi,
> 
> -O4 is a feature - for example MPlayer (www.mplayerhq.hu) using it.

Maybe you and the mplayer folks want to take a look at gcc's "handling"
of -O4..

