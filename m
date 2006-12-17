Return-Path: <linux-kernel-owner+w=401wt.eu-S1752513AbWLQMSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbWLQMSF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbWLQMSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:18:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:49827 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbWLQMSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:18:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZgZVPvBnIAs5jpxvdC/zOH2dMRfRg8yCrHIdjkCEdwh/jpAWDwtsrZzGvtFqha48Yq0TTQOtYxUihB9RU0Ip9NBjA8ndvBX8zCVjXSlJDzUfUT81IAlI3olnTtZ3JIRt7Ybrojq89MAkvA69GbmsNAr86l6MvSXNT4hcuG6Sknk=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Marek Wawrzyczny <marekw1977@yahoo.com.au>
Subject: Re: Binary Drivers
Date: Sun, 17 Dec 2006 13:17:13 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <loom.20061215T220806-362@post.gmane.org> <200612162007.32110.marekw1977@yahoo.com.au>
In-Reply-To: <200612162007.32110.marekw1977@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612171317.13262.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 December 2006 10:07, Marek Wawrzyczny wrote:
> The open source driver development is promising but it has been mentioned 
> several times that the project is undermanned and the vendors are not 
> forthcoming with the necessary information.
> My hardware as it stands today is still not working with the open-source 
> drivers. Perhaps this is the case of PEBCAK and not the open-source drivers 
> per se but with a 1-4 hour turnaround to test a new version of the r300 
> driver it is not a small effort on my part. Still, I'm eagerly awaiting the 
> day that I'll be able to use an open-source driver that is on par with the 
> ati one.

I buy the hardware. I actually want to get enough information about it
so that I can write a driver for it for my homegrown OS.

In the "old days" hardware was accompanied with such info.
For example, printers had control ESC sequences listed, etc.

These days, printers come with elaborate idiot-proof manuals
"how to properly connect your printer to the AC outlet"
and "how to properly insert Windows driver CD".

Ever met those Windows-only "GDI" printers which do not speak
any known open standard (they eat proprietary bitmap input instead)?

Why vendor has a right to restrict me to a few existing OSes?

I think that something is wrong here. Are there countries where
such practuce (of not providing tech info for writing drivers)
is illegal?
--
vda
