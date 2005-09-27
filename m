Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVI0Wpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVI0Wpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVI0Wpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:45:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52609 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751105AbVI0Wph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:45:37 -0400
Date: Tue, 27 Sep 2005 15:45:17 -0700
From: Paul Jackson <pj@sgi.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: haveblue@us.ibm.com, mrmacman_g4@mac.com, akpm@osdl.org,
       lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, mel@csn.ul.ie, kravetz@us.ibm.com
Subject: Re: [Lhms-devel] Re: [PATCH 1/9] add defrag flags
Message-Id: <20050927154517.4b6f5e70.pj@sgi.com>
In-Reply-To: <4339C1C6.8040202@austin.ibm.com>
References: <4338537E.8070603@austin.ibm.com>
	<43385412.5080506@austin.ibm.com>
	<21024267-29C3-4657-9C45-17D186EAD808@mac.com>
	<1127780648.10315.12.camel@localhost>
	<20050926224439.056eaf8d.pj@sgi.com>
	<433991A0.7000803@austin.ibm.com>
	<20050927123055.0ad9c2b4.pj@sgi.com>
	<4339B2F6.1070806@austin.ibm.com>
	<20050927142355.232f6e95.pj@sgi.com>
	<4339C1C6.8040202@austin.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+	 * Mark as __GFP_USER because from a fragmentation avoidance and
+	 * reclimation point of view this memory behaves like user memory.

You misspelled reclamation.

(Nice comment - I had to bitch about something ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
