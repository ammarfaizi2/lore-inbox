Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbTF1TLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTF1TLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:11:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46730
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265366AbTF1TLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:11:12 -0400
Subject: Re: How to Avoid GPL Issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "G. C." <gpc01532@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY8-F20kf6etlmIWMA00004812@hotmail.com>
References: <BAY8-F20kf6etlmIWMA00004812@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056828155.6289.33.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 20:22:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-28 at 00:04, G. C. wrote:
> Dear Sir or Madam,
> 
> We are trying to port a third party hardware driver into Linux kernel and 
> this third party vendor does not allow us to publish the source code. Is 
> there any approach that we can avoid publicizing the third party code while 
> porting to Linux? Do we need to write some shim layer code in Linux kernel 
> to interface the third party code? How can we do that? Is there any document 
> or samples?
> 
> Thank you very much in advance,

I can understand why you asked the question here, but you need to ask a
lawyer. The GPL license forbids derivative works being nonfree (eg
binary only). Your question boils down to "what is not a derivative
work", which is a lawyer not a programmer question

