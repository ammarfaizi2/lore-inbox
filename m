Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270227AbTGRMLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270228AbTGRMLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:11:36 -0400
Received: from 65-124-64-15.rdsl.ktc.com ([65.124.64.15]:16825 "EHLO
	csi.csimillwork.com") by vger.kernel.org with ESMTP id S270227AbTGRMLd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:11:33 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: <linux-kernel@vger.kernel.org>
Subject: run-parts,find, kupdated: What are they and how to control them?
Date: Fri, 18 Jul 2003 09:25:24 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200307180925.24867.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please - can someone explain what happens here once a day when my machine 
becomes completely unusable, a tremendous amount of disk i/o begins to occur, 
and 'top' shows "run-parts" and "find" at > 80% cpu utilization. What are 
they doing?  Are they necessary?  Can they be controlled. In Googling for 
these answers first, all I see are compaints, but no answers. Can someone 
PLEASE either explain what these are doing and how they are controlled, or 
point me in the right direction? Many thanks.

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
