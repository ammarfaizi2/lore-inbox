Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVHQIXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVHQIXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 04:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVHQIXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 04:23:22 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:19134 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750987AbVHQIXV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 04:23:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RckS9VtsSctNtPkL4H2FFKbhIwL+ww6LqFM/CCk+lNiX7Yf5GFGVb/Xpo27cSftUK6Cn2g0XW64ejJQzfbiAEEWmDhTF7wgAFBnvcNUU3Cqu2q1FPa7mxQt/Y7ZpAlYfpe6Agne7GBFFsArRXvfT4mhKfcYrxDT2eheA/3IfwO8=
Message-ID: <67657b5d05081701236df21b0f@mail.gmail.com>
Date: Wed, 17 Aug 2005 16:23:18 +0800
From: first last <tcsdownload@gmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: can we power off PCI device?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:
 We did a search on the net and found several related topics like PCI
device power management but we are 100% sure if this is what we are
looking for. Then, we would like to get some inputs from gurus like
you....

 We are working a PCI device driver on kernel 2.4 (Redhat 9) and
kernel 2.6 (Fedora) and we would like to power off then power on the
PCI device, which is manufactured by our company. Is it possible to do
that? Could you guys instrust me by
giving us the functions we have to call?

many thanks

tcs
