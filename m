Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUJAXKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUJAXKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 19:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUJAXK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 19:10:29 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:41886 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266810AbUJAXJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 19:09:29 -0400
Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "Mukker, Atul" <Atulm@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C989@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230C989@exa-atlanta>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Oct 2004 19:09:14 -0400
Message-Id: <1096672161.1766.127.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 18:52, Bagalkote, Sreenivas wrote:
> Would you please send us your version of megaraid driver that will
> most likely go into 2.6.9? We would like baseline your version and
> make our internal releases off of that. I appreciate your help.

You can get my tree in bitkeeper here

bk://linux-scsi.bkbits.net/scsi-misc-2.6

Or, you can get it (with a slight time lag) in the -mm tree:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/

James


