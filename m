Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTELOue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTELOue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:50:34 -0400
Received: from holomorphy.com ([66.224.33.161]:40881 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262176AbTELOue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:50:34 -0400
Date: Mon, 12 May 2003 08:03:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, haveblue@us.ibm.com
Subject: Re: 2.5.69-mjb1
Message-ID: <20030512150309.GG19053@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>, haveblue@us.ibm.com
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21850000.1052743254@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 05:40:55AM -0700, Martin J. Bligh wrote:
> Can I get some sort of vague explanation please? ;-)

How obvious does it have to be?

Those are trying to fish out the 2nd and 5th words from the top of the
stack. Magic numbers stopped working; symbolic constants save the day.


-- wli
