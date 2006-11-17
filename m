Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755899AbWKQVBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbWKQVBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbWKQVBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:01:11 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:46498 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755899AbWKQVBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:09 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 00/15] Roll-up of my libsas, aic94xx and sas_ata patches
Date: Fri, 17 Nov 2006 13:07:37 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

This is a roll-up of all of my patches against libsas, aic94xx and
sas_ata to date.  The only new patches are #4-5 and #12-15; everything
else has already been seen in some form on this mailing list.
Hopefully this will make things a bit saner since most of these have
been floating out over the past 3 weeks. :)

(Apologies for any stgit mail misconfiguration on my part.)

--D
