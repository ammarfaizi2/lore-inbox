Return-Path: <linux-kernel-owner+w=401wt.eu-S932961AbWL0HTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961AbWL0HTc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 02:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbWL0HTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 02:19:32 -0500
Received: from ag-out-0708.google.com ([72.14.246.249]:15834 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961AbWL0HTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 02:19:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=SKlfFt1tO3vZGBveTmcpAyryiAbhzYDDzfUQCidfb4YhixkTJkWKTvW0xoMFbh0AMpiTkwmYYcIhFbOp7jFPwmp2Q1mPD82HWZr0HTumY7OrlXGFbVVUZHZnDg3dityiQwIh1syQl5vCHRWhEMRFsXGx7mYSu3BaP6joGsrNI7s=
Message-ID: <45921E73.1080601@gmail.com>
Date: Wed, 27 Dec 2006 16:19:15 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Rene Herman <rene.herman@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATA -- pata_amd on 2.6.19 fails to IDENTIFY my DVD-ROM
References: <45893CAD.9050909@gmail.com>
In-Reply-To: <45893CAD.9050909@gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Good day.
> 
> I just tried the PATA driver for my AMD756 chip. During boot, it hangs
> for 3 minutes failing to identify my DVD-ROM (secondary slave) and does
> not give me access to it after it timed out.

Please give a shot at v2.6.20-rc2 and report what the kernel says.

Thanks.

-- 
tejun
