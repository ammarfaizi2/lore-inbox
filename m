Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVB1Qvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVB1Qvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVB1Qud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:50:33 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:4477 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261688AbVB1Qsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:48:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=epdCUSFoBqurwL/GFEIMBbGTXLdqPxi1gL1+oxiRWF2+itI9wFNaTSxqsWgOAV+m5NIrpZipih3o//BUyYNRA6y1NNNlZMpoLTlkKkde3DOe9zmtoUmFQ63XhMq1Roaz8S3Y5PVEqlUJl3GA6c49uC5c/41Xch6tbn15EMjrofU=
Message-ID: <f2833c7605022808486c81bd33@mail.gmail.com>
Date: Mon, 28 Feb 2005 10:48:47 -0600
From: "Timothy R. Chavez" <chavezt@gmail.com>
Reply-To: "Timothy R. Chavez" <chavezt@gmail.com>
To: Ravindra Nadgauda <rnadgauda@velankani.com>
Subject: Re: Signals/ Communication from kernel to user!
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <042701c51dab$561ef650$280e000a@blr.velankani.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42233772.7020409@structurenet.com>
	 <042701c51dab$561ef650$280e000a@blr.velankani.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005 21:06:57 +0530, Ravindra Nadgauda
<rnadgauda@velankani.com> wrote:
> 
> 
> Hello,
>    We wanted to establish a communication from kernel module (possibly a
> driver) to a user level process.
> 
>    Wanted to know whether signals can be used for this purpose OR there any
> other (better) methods of communication??

Perhaps netlink?  Here's an introduction: http://qos.ittc.ku.edu/netlink/html/

> 
> Regards,
> Ravindra N.
 
-- 
- Timothy R. Chavez
