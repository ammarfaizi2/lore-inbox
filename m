Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVBYDKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVBYDKD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 22:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVBYDKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 22:10:02 -0500
Received: from mailgate1.dslextreme.com ([66.51.199.94]:19655 "EHLO
	mailgate1.dslextreme.com") by vger.kernel.org with ESMTP
	id S262607AbVBYDJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 22:09:54 -0500
Message-ID: <421E96AF.1070908@colannino.org>
Date: Thu, 24 Feb 2005 19:08:31 -0800
From: James Colannino <lkml@colannino.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: how to capture kernel panics
References: <52765.69.93.110.242.1109288148.squirrel@69.93.110.242>
In-Reply-To: <52765.69.93.110.242.1109288148.squirrel@69.93.110.242>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DSLExtreme-MailGate-Information: Please contact the ISP for more information
X-DSLExtreme-MailGate: Found to be clean
X-MailScanner-From: lkml@colannino.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shabanip wrote:

>is there any way to capture and log kernel panics on disk or ...?
>  
>

My guess would be, at the very least, it depends on what part of the 
kernel is causing the panic.  Most likely I would say no, although 
here's another question: if running a second kernel under user-mode 
Linux, can this be done?

James
