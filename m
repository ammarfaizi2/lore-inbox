Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbUKJMBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUKJMBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 07:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbUKJMBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 07:01:32 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:33166 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261692AbUKJMBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 07:01:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=qFseue/Li90EqGklxgtt8R9456SArXGWZHHUjXSrL6DrKX85D+1vmcpN8aHfRauPmIwQWnvBN7J/+0SdSLPb+JEUSsZRSUjnYSBAj+EVaW4Nqz/92hZ+kx6NjEVbImTsJl+bvtOUiGc/01rpq6AqoDTD/YHcp38LowUW2IQPYHM=
Message-ID: <64b1faec041110040117a80877@mail.gmail.com>
Date: Wed, 10 Nov 2004 13:01:31 +0100
From: Sylvain <autofr@gmail.com>
Reply-To: Sylvain <autofr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: question about MM on x86
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am interested in the way memory management is implemented on x86,
specially the low level part.

I search: where physical address are computed when a new Frame new to
be allocated but I can't find out. (alogithm to find out the next
frame free?? other the next frame to reuse??)

Please, can somebody  familiar with the code point me to very prescise
function, or give me some hint.

Thanks in advance,

Sylvain
