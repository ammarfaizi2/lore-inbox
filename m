Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSLIIpJ>; Mon, 9 Dec 2002 03:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSLIIpJ>; Mon, 9 Dec 2002 03:45:09 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:49381 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S264672AbSLIIpJ> convert rfc822-to-8bit; Mon, 9 Dec 2002 03:45:09 -0500
From: rasman@uk.ibm.com
Reply-To: rasman@uk.ibm.com
Organization: IBM
To: Chris Ison <cisos@bigpond.net.au>
Subject: Re: kernel module and user space functions
Date: Mon, 9 Dec 2002 08:50:35 +0000
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200212090850.35515.rasman@uk.ibm.com>
X-MIMETrack: Itemize by SMTP Server on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 09/12/2002 08:52:38,
	Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 09/12/2002 08:52:42,
	Serialize complete at 09/12/2002 08:52:42
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
  charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ison wrote:

> How can I get a kernel module to use functions within an executable,
> please reply with example?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

It can't - allowing that would break the whole basis of system integrity.

-- 
Richard J Moore
RAS Team Lead - IBM Linux Technology Centre
