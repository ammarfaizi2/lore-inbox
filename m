Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbTHVRP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 13:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTHVRPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 13:15:54 -0400
Received: from holomorphy.com ([66.224.33.161]:3223 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265390AbTHVRPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 13:15:50 -0400
Date: Fri, 22 Aug 2003 10:16:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Message-ID: <20030822171625.GM4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Theurer <habanero@us.ibm.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <200308201658.05433.habanero@us.ibm.com> <200308211056.29876.habanero@us.ibm.com> <1061482159.19036.1716.camel@nighthawk> <200308211202.02871.habanero@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308211202.02871.habanero@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 12:02:02PM -0500, Andrew Theurer wrote:
> Boot log with extra kicked++ removed...

Say, could you try last night's bk snapshot and let me know how it's
doing? I threw in a necessary fix on top of Dave's last night, but I
don't know whether it's sufficient for your purposes yet.


-- wli
