Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbTGaUIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 16:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbTGaUIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 16:08:42 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:49104 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S269237AbTGaUIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 16:08:41 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Timothy Miller <miller@techsource.com>
Date: Thu, 31 Jul 2003 22:08:26 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Turning off automatic screen clanking
Cc: Linux kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <8D353DD1F2D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jul 03 at 15:55, Timothy Miller wrote:
> So, if there's no point to having screen-blanking, why is it in there to 
> begin with?  To protect OLD monitors from burnin?

For example. My 8 years old EIZO F764M must not be powered down/powersaved
for more than few seconds, otherwise it takes about two days to get 
convergence back right (monitor "fixes" itself, it is just unusable until
it does so as there is about 0.5cm distance between red and green and
green and blue components...).
 
> Is screen-blanking there just to make people feel better who think they 
> need screen-blanking?  As I understand, it doesn't do any 
> power-management stuff anyhow.

setterm -powersave powerdown. I used it until monitor told me that it was
bad idea.
                                                    Petr Vandrovec
                                                    

