Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266151AbTGDTxu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbTGDTxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:53:50 -0400
Received: from holomorphy.com ([66.224.33.161]:20353 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266151AbTGDTxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:53:08 -0400
Date: Fri, 4 Jul 2003 13:08:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, zboszor@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030704200855.GG955@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>, zboszor@freemail.hu,
	linux-kernel@vger.kernel.org
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu> <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no> <20030703141508.796e4b82.akpm@osdl.org> <20030704200046.GA1167@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704200046.GA1167@hh.idb.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 10:00:46PM +0200, Helge Hafting wrote:
> I'm sorry, both cpu's are up.  I did a better test
> with busy loops.  One high-priority (nice --10)
> busy loop has no effect on performance, two such ones
> makes the mouse cursor very jumpy. 
> So both cpus are working, after all and not merely being
> detected.  I'm using gcc 3.3 from debian testing.

Same compiler I'm using, which has been seen to work.


-- wli
