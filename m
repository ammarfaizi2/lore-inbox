Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbUCPGBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 01:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbUCPGBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 01:01:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24516 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262893AbUCPGBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 01:01:46 -0500
Message-ID: <4056983B.9010609@pobox.com>
Date: Tue, 16 Mar 2004 01:01:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
CC: prism54-devel@prism54.org, netdev <netdev@oss.sgi.com>,
       linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: Re: Prism54 Driver Project Complete
References: <20040316055249.GE24063@ruslug.rutgers.edu>
In-Reply-To: <20040316055249.GE24063@ruslug.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There still needs to be a central "maintainer" of prism54, someone who 
sends patches either directly to me, or via Jean to me (maintainer's 
choice).  Ideally, it is best to funnel patches from everybody through 
driver-maintainer -> subsystem maintainer -> Marcelo|Andrew|Linus.  That 
only breaks down when the driver or subsystem maintainer is too slow, 
and doesn't follow the "release early, release often" precept :)

Open source is about lack of control, and trusting that community and 
consensus will produce superior software over the long run...  but lack 
of control doesn't mean lack of organization :)

	Jeff




