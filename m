Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTJ3ITp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 03:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTJ3ITp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 03:19:45 -0500
Received: from soft.uni-linz.ac.at ([140.78.95.99]:47016 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id S262221AbTJ3ITo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 03:19:44 -0500
Message-ID: <3FA0C99C.5070709@soft.uni-linz.ac.at>
Date: Thu, 30 Oct 2003 09:19:40 +0100
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Burjan Gabor <buga@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 usbserial/pl2303 oops
References: <20031027083406.GA9326@odin.sis.hu> <20031027234233.GB3408@kroah.com> <20031029001731.GA20355@odin.sis.hu> <3F9F830F.6010803@soft.uni-linz.ac.at> <20031029155515.GA3457@kroah.com>
In-Reply-To: <20031029155515.GA3457@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it does with  2.4.23-pre8, i will check the test9 as well
Simon

Greg KH wrote:
> On Wed, Oct 29, 2003 at 10:06:23AM +0100, Simon Vogl wrote:
> 
>>I have a different problem with the pl2303 module, but have
>>no clue where to search: I have an ericsson cradle that I
>>check repeatedly if a cell phone is plugged in or not.
> 
> 
> Does this happen on the latest 2.4.23-pre8 kernel?  Does this happen on
> 2.6.0-test9?
> 
> thanks,
> 
> greg k-h

-- 
------------------------------------------------
Dr. Simon Vogl
Department  of   Computer  Science
Johannes Kepler University of Linz
Altenberger Straﬂe 69
A-4040 Linz - Austria

Tel: +43 70 2468 8517  vogl@soft.uni-linz.ac.at
Fax: +43 70 2468 8426   www.soft.uni-linz.ac.at

