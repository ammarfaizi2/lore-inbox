Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTKRSOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 13:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTKRSOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 13:14:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:43973 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263760AbTKRSOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 13:14:34 -0500
X-Authenticated: #4512188
Message-ID: <3FBA6264.3060003@gmx.de>
Date: Tue, 18 Nov 2003 19:18:12 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Marcus Hartig <marcus@marcush.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9 /-mm3 SATA siimage - bad disk performance
References: <3FB5B74E.5080707@marcush.de> <3FB5EDC1.8010805@gmx.de> <3FB6685A.8010607@marcush.de> <3FB66C9F.8070008@gmx.de> <3FB67BE0.4080301@marcush.de>
In-Reply-To: <3FB67BE0.4080301@marcush.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Hartig wrote:
> Prakash K. Cheemplavam wrote:
> 
>> Is there a way to change the latency within Linux? I mean I don't want 
> 
> 
> With setpci and lspci?

Well, I treid setting latenc to 64 even 128, but hd-speed didn't 
improve. 23MB/s was max. What else did you set? I just set the siimage 
controller's latency higher.

Prakash


