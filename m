Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUDWVG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUDWVG7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUDWVG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:06:59 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30448 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261422AbUDWVG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:06:58 -0400
In-Reply-To: <20040423142445.GC501@grc.nasa.gov>
To: weddy@grc.nasa.gov
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Subject: Re: TCP rto estimation patch
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFE28EC49F.335C9D5D-ON88256E7F.0073BC2E-88256E7F.0073F700@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Fri, 23 Apr 2004 14:06:39 -0700
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.0.2CF2HF168 | December 5, 2003) at
 04/23/2004 15:06:40,
	Serialize complete at 04/23/2004 15:06:40
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe "2" and "3" are the scale factors for the fixed-point 
representation
of the data, not the "alpha" and "beta" I remember from the estimator 
paper.

                                +-DLS

