Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWALJ5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWALJ5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWALJ5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:57:47 -0500
Received: from mail.asc.de ([82.100.219.35]:14891 "EHLO mail.asc.de")
	by vger.kernel.org with ESMTP id S1030342AbWALJ5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:57:46 -0500
Message-ID: <43C62818.6030001@asc.de>
Date: Thu, 12 Jan 2006 10:57:44 +0100
From: Reinhold Jordan <r.jordan@asc.de>
Organization: ASC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: option memmap
References: <43C51ABD.4050204@asc.de>
In-Reply-To: <43C51ABD.4050204@asc.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Jan 2006 09:57:44.0952 (UTC) FILETIME=[A2A1DF80:01C6175E]
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is there any problem with this question? Who should I ask
kernel dependent questions beside the kernel developers?

Regards, Reinhold

Reinhold Jordan wrote:
> Hello,
> 
> is there any documentation for this option better than this in
> linux/Documentation/kernel-parameters.txt ?
> 
> I have a laptop with a defect memory soldered on the main-board.
> 128KB of 128MB are defect started at 7936KB
> 
> As I read from kernel-parameters.txt the option
> memmap=128K$7936K
> reserve this area. But this seems to be simply ignored. Even, if I
> fade out 64MB, Knoppix still create a RAM disk, which is larger
> as the remaining memory...
> 
> Does someone know advice?

-- 
ASC telecom AG                   Research & Development
Seibelstr. 2                     F: +49-6021-5001-309
D-63768 Hösbach                  E: r.jordan@asc.de
      Visit us on http://www.asctelecom.com
