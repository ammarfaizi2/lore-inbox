Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268215AbTBNGT3>; Fri, 14 Feb 2003 01:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268217AbTBNGT3>; Fri, 14 Feb 2003 01:19:29 -0500
Received: from [196.41.29.142] ([196.41.29.142]:11016 "EHLO
	andromeda.cpt.sahara.co.za") by vger.kernel.org with ESMTP
	id <S268215AbTBNGT2>; Fri, 14 Feb 2003 01:19:28 -0500
Subject: Re: Problems with 2.5.*'s SCSI headers and cdrtools
From: Sahara Workshop <workshop@cpt.saharapc.co.za>
To: Christoph Hellwig <hch@infradead.org>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030214062109.A18761@infradead.org>
References: <1045201685.5971.78.camel@workshop.saharact.lan>
	 <20030214055822.A18415@infradead.org>
	 <1045202851.5971.83.camel@workshop.saharact.lan>
	 <20030214062109.A18761@infradead.org>
X-scanner: scanned by Sistech VirusWall 2.3/cpt
Content-Type: text/plain
Organization: 
Message-Id: <1045204070.5971.92.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 14 Feb 2003 08:27:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 08:21, Christoph Hellwig wrote:

> Glibc's <scsi/scsi.h>


If you looked at the patch, you would have seen that it
does include 'scsi/scsi.h', but I'm guessing its changing the
search order of includes then.  Ill have a look.


-- 
Sahara Workshop <workshop@cpt.saharapc.co.za>



-  PLEASE NOTE -

This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager. Please note that any views or opinions presented
in this email are solely those of the author and do not necessarily
represent those of Sahara Distribution (Pty) Ltd. Finally, while Sahara
Distribution attempts to ensure that all email is virus-free, Sahara
Distribution accepts no liability for any damage caused by any virus
transmitted by this email.

Sahara Distribution (PTY) Ltd
Unit G5-G12, Centurion Business Park, Milnerton, Cape Town, South Africa
Private Bag X180, Halfway House, 1685, South Africa

Scanned and protected by Sistech Viruswall 2.3

