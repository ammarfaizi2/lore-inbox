Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318883AbSIIWCu>; Mon, 9 Sep 2002 18:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318886AbSIIWCu>; Mon, 9 Sep 2002 18:02:50 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:18160
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318883AbSIIWCt>; Mon, 9 Sep 2002 18:02:49 -0400
Subject: Re: LMbench2.0 results
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D7D1643.A6317BBE@digeo.com>
References: <3D7B9988.6B8CD04F@digeo.com>
	<1031606032.29715.58.camel@irongate.swansea.linux.org.uk> 
	<3D7D1643.A6317BBE@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 23:09:39 +0100
Message-Id: <1031609379.29793.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 22:44, Andrew Morton wrote:
> Does "heuristic" overcommit handling need so much accuracy?
> Perhaps we can push some of the cost over into mode 2 somehow.

Its only needed in mode 2, but its also only computed for mode 2,3 in
2,4 8)

