Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270528AbRHSOoC>; Sun, 19 Aug 2001 10:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270520AbRHSOnv>; Sun, 19 Aug 2001 10:43:51 -0400
Received: from cogent.ecohler.net ([216.135.202.106]:44988 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S270521AbRHSOnk>; Sun, 19 Aug 2001 10:43:40 -0400
Date: Sun, 19 Aug 2001 10:43:45 -0400
From: lists@sapience.com
To: Robert Love <rml@tech9.net>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <20010819104345.A11696@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998193404.653.12.camel@phantasy>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Perhaps the patch does this already, but if there are concerns about
 pollution from the nasty outside is it possible to add a flag to /proc
 to turn this on/off by interface - that way it could easily be limited
 to only get influenced by the inside network rather than the outside.

 Regards,

 gene/
 lists@sapience.com

