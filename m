Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVFVUbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVFVUbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVFVUZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:25:31 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46280 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262025AbVFVUYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:24:19 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200506222024.j5MKO5nD023262@fsgi900.americas.sgi.com>
Subject: [PATCH 2.6] Altix - add ioc3 serial driver support
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Jun 2005 15:24:05 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a patch : ftp://oss.sgi.com/projects/sn2/sn2-update/042-ioc3-support

This driver adds support for a 2 port PCI IOC3 serial card on Altix boxes.

Signed-off-by: Patrick Gefre <pfg@sgi.com>

-- 

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054
