Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVBQNIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVBQNIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 08:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVBQNIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 08:08:44 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:4871 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262133AbVBQNIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 08:08:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=uBRgGb6awC1FZQN49KRpmEAt+3tF8+c6TGTzXV5ujDdNk0VO1ZGtgsehdDdtdzEgmYaS8NDqNcRoGiHNveBc036IoV9ocfjMitIxuOgcsbMcvRpNftEZuLjCvFed6DV3Lg9OlfZPEdJw1SnVnTdmTAi6eGQRDZAPt2Z6XQcuHP0=
Reply-To: marc.cramdal@gmail.com
To: linux-kernel@vger.kernel.org
Subject: AMD 64 and Kernel AGPart support
Date: Thu, 17 Feb 2005 15:08:32 +0100
User-Agent: KMail/1.7.92
References: <4213AB2B.2050604@giesskaennchen.de>
In-Reply-To: <4213AB2B.2050604@giesskaennchen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502171508.33052.marc.cramdal@gmail.com>
From: Marc Cramdal <bruno.virlet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an AMD 64 (gentoo compiled for amd64) and I would like to succeed in my 
video driver installation (ATI Radeon 9250 :-/). I would need the agpgart 
support for the Sis Chipset, but all the entry for agpgart are grayed, I 
can't change anything (Kernel 2.6.9, 2.6.10 ...)

So is it normal or a bug ?? , or am I making a mistake.

NB: one of my friends made the test, without AMD64 and exactly the same kernel 
he can check these options within agpgart...

Thanks,
Marc
