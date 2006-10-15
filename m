Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752327AbWJOBvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbWJOBvE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 21:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbWJOBvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 21:51:04 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:8978 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1752327AbWJOBvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 21:51:02 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Kevin K <k_krieser@sbcglobal.net>
Subject: Re: Driver model.. expel legacy drivers?
Date: Sun, 15 Oct 2006 02:51:04 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <4530570B.7030500@comcast.net> <45317814.8000709@comcast.net> <73CDF2F1-EC0A-431D-9B29-10251FAD21B7@sbcglobal.net>
In-Reply-To: <73CDF2F1-EC0A-431D-9B29-10251FAD21B7@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610150251.04147.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 October 2006 02:24, Kevin K wrote:
> On Oct 14, 2006, at 6:51 PM, John Richard Moser wrote:
> >> Microsoft are also being very helpful. They are making it harder and
> >> harder for people to use drivers not microsoft-signed which in turns
> >> pushes up costs for development and as a result encourages more
> >> standardization of driver interfaces to take place.
> >
> > huh?
>
> My assumption is that vendors may make fewer gratuitious interface
> changes so the hardware is more likely to work with existing, signed,
> drivers.  If changes aren't made, existing Linux drivers are more
> likely to work with new revisions of hardware.
>
> My experience in the past for hardware, such as USB based flash
> memory readers, is that when they came out you seemed to always need
> a proprietary driver, and Linux drivers needed hints for different
> readers.  It seems better these days, with things like USB keys
> generally working in both Windows and relatively modern distributions
> without much effort.

Alan's talking about standards like AHCI, {U,O,E}HCI, AC'97, all standards for 
silicon that make writing generic drivers possible.

I'm patiently waiting for an equivalent for wireless, or graphics (hopefully 
not another VESA)..

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
