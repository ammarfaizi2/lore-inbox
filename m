Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWHEN2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWHEN2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 09:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWHEN2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 09:28:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:6020 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422634AbWHEN2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 09:28:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nog/SaUKL/a+/MdmTG/EV73XWXlGs413t/6HqIDSnzdTsH1IQFhBqVK4st2aeuQXMwJLih+YCdgdBPC6rqg5/AxHp/hSJ1rYY5axTU7WWCXou3HX2Wns/gwcnXI5Kumsu6Ws8ANDAZW70phgshsZ+fKi6cB+XPHj/6NhJzQ+Rg8=
Message-ID: <62b0912f0608050628v78dcc5c2k75970d6d32f90748@mail.gmail.com>
Date: Sat, 5 Aug 2006 15:28:40 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: e100: checksum mismatch on 82551ER rev10
Cc: auke-jan.h.kok@intel.com, charlieb@budge.apana.org.au,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060804.042834.78730901.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D0D7CA.2060001@intel.com>
	 <62b0912f0608040404p59545a0asc7f5fc5f537ec32c@mail.gmail.com>
	 <20060804.042024.63108922.davem@davemloft.net>
	 <20060804.042834.78730901.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> Please put the option into the e100 driver to allow trying to use the
> device even if the EEPROM checksum is wrong.

Whee, the users win! :-)

> If an Intel developer doesn't do it, I will.

I hope you don't piss off the nice guys at Intel who contribute source
code to the Linux kernel so much that they go away.

For what it's worth, a redistributable utility to fix the EEPROM
checksum would be just as fine a solution (for me)...  if only one was
available.
