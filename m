Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSGTBT6>; Fri, 19 Jul 2002 21:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSGTBT6>; Fri, 19 Jul 2002 21:19:58 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:15884 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S317299AbSGTBT5>; Fri, 19 Jul 2002 21:19:57 -0400
Date: Sat, 20 Jul 2002 02:22:50 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild - building a module/target from multiple directories
Message-ID: <20020720012250.GA41640@compsoc.man.ac.uk>
References: <20020720002521.GA34954@compsoc.man.ac.uk> <Pine.LNX.4.44.0207191845240.3378-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207191845240.3378-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
X-Scanner: exiscan *17VixR-000Ajw-00*FCAJD/eC/j2* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 06:46:57PM -0600, Thunder from the hill wrote:

> blah-objs := blah_init.o blahstuff/blahstuff.o

It won't descend to blahstuff/ directory then

(in fact it tries to build blahstuff/blahstuff.s)

regards
john

-- 
"Of all manifestations of power, restraint impresses the most."
	- Thucydides
