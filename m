Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWBTVZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWBTVZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWBTVZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:25:42 -0500
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:33687 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1030182AbWBTVZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:25:41 -0500
Message-ID: <43FA33DF.1050200@keyaccess.nl>
Date: Mon, 20 Feb 2006 22:25:51 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Mozilla Thunderbird posting instructions wanted
References: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
In-Reply-To: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

 > This  POS is pretty popular among kernel janitors, so, can someone who
 > is successfully using it, please, post crystally clear step-by-step
 > instructions on how to send a foo.patch:
 > 	inline
 > 	with tabs preserved
 > 	with long lines preserved

Oh, give it up...

 > Sending plain text attachments is OK with me, but, heh, people do post
 > patches inline and screw themselves.

Personally I'd simply advocate plain text attachments. One thing though; 
if you are going to, please make note of the long (long) standing bug in 
TB that has it send all attachments (including plaintext ones) Base64 
encoded when the outgoing encoding is set to UTF-8.

I do normally have outgoing set to UTF-8 and for example forgot to 
disable that earlier today when I sent an OOPS as an attachment. You 
don't immediately notice this yourself, since TB simply decodes it again 
when viewing...

Rene.
