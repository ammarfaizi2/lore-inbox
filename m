Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSLMTHW>; Fri, 13 Dec 2002 14:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSLMTHW>; Fri, 13 Dec 2002 14:07:22 -0500
Received: from spiderman.spectsoft.com ([216.126.222.67]:45316 "EHLO
	trashbin1.spectsoft.com") by vger.kernel.org with ESMTP
	id <S265275AbSLMTHV>; Fri, 13 Dec 2002 14:07:21 -0500
Subject: DMA from SCSI controller to PCI frame buffer memory.
From: Jason Howard <lists@spectsoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: SpectSoft, LLC
Message-Id: <1039806910.21196.29.camel@bmagic.spectsoft.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Dec 2002 11:15:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am wondering if the functionality exists in the Linux kernel to DMA 
from a SCSI controller directly into frame buffer memory of a PCI video
card?  Is there a standard method for this (similar to sendfile) or will
it require some hacking?

Jason

-- 
 Jason Howard

Professional:
  SpectSoft, LLC
  http://www.spectsoft.com  jason@spectsoft.com      
  Phone: +1.209.847.7812    Fax: +1.209.847.7859
Personal:
  http://www.psinux.org     jason@psinux.org
  Cell: +1.209.968.1289
  Text Message: jasonsphone@psinux.org


