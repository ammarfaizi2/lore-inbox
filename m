Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWJBCk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWJBCk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 22:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWJBCk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 22:40:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:47163 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932600AbWJBCk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 22:40:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WDgkRHUF7ZL6WQzxygA5nY6G0zxWk878wk5/TxQT3LOSXgQnN2NC7RfywRYOxiMlvxcc35x1G9X7CxdmGtEx9cz5n4xD5DdYLbFkPvCQsxngLn35y8+rSujAOPwYyG8JWujD0e+C0mo+Z3KNcw/8iKiv6Qs4okaV75mU7wxRmrI=
Message-ID: <62b0912f0610011940n1e2f2748k87eaa430a75113d7@mail.gmail.com>
Date: Mon, 2 Oct 2006 04:40:57 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
In-Reply-To: <4517CB2C.7020807@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <20060810030602.GA29664@mail>
	 <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
	 <44DB2436.6080501@aitel.hist.no>
	 <62b0912f0609240156p21caf564qc20b82b2ee4d8f43@mail.gmail.com>
	 <4517CB2C.7020807@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> [snip]

Well, that was unproductive :-).

If anyone knows how to make forced unmounting work, hints would be
greatly appreciated.

To reiterate:
The distro halt script tries "umount -f" three times, which all fail with
"Device or resource busy".
